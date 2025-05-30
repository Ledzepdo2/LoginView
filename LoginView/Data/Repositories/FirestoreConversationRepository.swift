//
//  FirestoreConversationRepository.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

final class FirestoreConversationRepository: ConversationRepositoryProtocol {
    private let dataSource: FirestoreConversationDataSource
    private let userRepository: UserRepositoryProtocol
    
    init(dataSource: FirestoreConversationDataSource, userRepository: UserRepositoryProtocol) {
        self.dataSource = dataSource
        self.userRepository = userRepository
    }

    func fetchConversations(for userId: String, completion: @escaping (Result<[Conversation], Error>) -> Void) {
        dataSource.fetchConversations(userId: userId) { result in
            switch result {
            case .success(let dtos):
                let group = DispatchGroup()
                var conversations = [Conversation]()
                
                for dto in dtos {
                    group.enter()
                    self.userRepository.fetchUsers(userIds: dto.participantIds) { usersResult in
                        if case .success(let users) = usersResult {
                            let conversation = dto.toDomain(participants: users, lastMessage: nil)
                            conversations.append(conversation)
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(.success(conversations))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
