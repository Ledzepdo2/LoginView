//
//  FirestoreAuthRepository.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import FirebaseAuth

final class FirestoreAuthRepository: AuthRepositoryProtocol {
    private let dataSource: AuthDataSource

    init(dataSource: AuthDataSource = FirestoreAuthDataSource()) {
        self.dataSource = dataSource
    }

    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        dataSource.login(email: username, password: password, completion: completion)
    }

    func signup(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        dataSource.signup(email: username, password: password, completion: completion)
    }

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        dataSource.logout(completion: completion)
    }
}
