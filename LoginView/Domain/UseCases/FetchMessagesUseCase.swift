//
//  FetchMessagesUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct FetchMessagesUseCase {
    private let repository: MessageRepositoryProtocol

    init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(conversationId: String, completion: @escaping (Result<[Message], Error>) -> Void) {
        repository.fetchMessages(conversationId: conversationId) { result in
            completion(result)
        }
    }
}
