//
//  SendMessageUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct SendMessageUseCase {
    private let repository: MessageRepositoryProtocol

    init(repository: MessageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(message: Message, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.sendMessage(message) { result in
            completion(result)
        }
    }
}
