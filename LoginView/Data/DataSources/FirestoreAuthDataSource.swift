//
//  FirestoreAuthDataSource.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import FirebaseAuth

protocol AuthDataSource {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signup(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirestoreAuthDataSource: AuthDataSource {
    private let auth = Auth.auth()

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error)); return
            }
            completion(.success(()))
        }
    }

    func signup(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error)); return
            }
            completion(.success(()))
        }
    }

    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
