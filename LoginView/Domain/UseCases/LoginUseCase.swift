//
//  LoginUseCase.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct LoginUseCase {
    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    func execute(username: String,
                 password: String,
                 completion: @escaping (Result<Void, Error>) -> Void) {
        authRepository.login(username: username, password: password) { result in
            completion(result)
        }
    }
}
