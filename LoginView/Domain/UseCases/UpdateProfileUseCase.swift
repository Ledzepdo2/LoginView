//
//  UpdateProfileUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct UpdateProfileUseCase {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.updateUser(user) { result in
            completion(result)
        }
    }
}
