//
//  FetchConversationsUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct FetchConversationsUseCase {
    private let repository: ConversationRepositoryProtocol

    init(repository: ConversationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(userId: String, completion: @escaping (Result<[Conversation], Error>) -> Void) {
        repository.fetchConversations(for: userId) { result in
            completion(result)
        }
    }
}
