//
//  UpdateProfileUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct UpdateProfileUseCase {
    private let userRepository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.userRepository = repository
    }

    func execute(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        userRepository.updateUser(user) { result in
            completion(result)
        }
    }
}
