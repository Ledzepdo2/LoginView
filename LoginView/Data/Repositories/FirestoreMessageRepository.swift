//
//  FirestoreMessageRepository.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import FirebaseFirestore

final class FirestoreMessageRepository: MessageRepositoryProtocol {
    func sendMessage(_ message: Message, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
    
    private let dataSource: FirestoreMessageDataSource
    private let userRepository: UserRepositoryProtocol
    
    init(dataSource: FirestoreMessageDataSource = .init(),
         userRepository: UserRepositoryProtocol = FirestoreUserRepository()) {
        self.dataSource = dataSource
        self.userRepository = userRepository
    }

    func fetchMessages(conversationId: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        dataSource.fetchMessages(conversationId: conversationId) { result in
            switch result {
            case .success(let dtos):
                let group = DispatchGroup()
                var messages = [Message]()
                var senders = [String: User]()
                
                let senderIds = dtos.map { $0.senderId }
                group.enter()
                self.userRepository.fetchUsers(userIds: senderIds) { usersResult in
                    if case .success(let users) = usersResult {
                        users.forEach { senders[$0.id] = $0 }
                    }
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    messages = dtos.compactMap { dto -> Message? in
                        guard let sender = senders[dto.senderId] else { return nil }
                        return dto.toDomain(sender: sender)
                    }
                    completion(.success(messages))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func sendMessage(_ message: Message, completion: @escaping (Result<Message, Error>) -> Void) {
        let dto = MessageDTO(
            id: message.id,
            conversationId: message.conversationId,
            senderId: message.sender.id,
            content: message.content,
            sentAt: message.sentAt
        )
        
        dataSource.sendMessage(dto) { [self] result in
            switch result {
            case .success:
                userRepository.fetchUser(id: dto.senderId) { userResult in
                    switch userResult {
                    case .success(let user):
                        let domainMessage = dto.toDomain(sender: user)
                        completion(.success(domainMessage))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func subscribeToMessages(conversationId: String, listener: @escaping (Result<[Message], Error>) -> Void) -> ListenerRegistration {
        return dataSource.subscribeToMessages(conversationId: conversationId) { result in
            switch result {
            case .success(let dtos):
                let group = DispatchGroup()
                var senders = [String: User]()
                
                let senderIds = dtos.map { $0.senderId }
                group.enter()
                self.userRepository.fetchUsers(userIds: senderIds) { usersResult in
                    if case .success(let users) = usersResult {
                        users.forEach { senders[$0.id] = $0 }
                    }
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    let messages = dtos.compactMap { dto -> Message? in
                        guard let sender = senders[dto.senderId] else { return nil }
                        return dto.toDomain(sender: sender)
                    }
                    listener(.success(messages))
                }
                
            case .failure(let error):
                listener(.failure(error))
            }
        }
    }
}
