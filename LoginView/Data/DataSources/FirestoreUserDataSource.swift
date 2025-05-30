//
//  FirestoreUserDataSource.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import FirebaseFirestore

protocol UserDataSource {
    func fetchUser(id: String, completion: @escaping (Result<UserDTO, Error>) -> Void)
    func updateUser(_ user: UserDTO, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirestoreUserDataSource: UserDataSource {
    private let store = Firestore.firestore()
    private var collection: CollectionReference { store.collection("users") }

    func fetchUser(id: String, completion: @escaping (Result<UserDTO, Error>) -> Void) {
        collection.document(id).getDocument { snap, error in
            if let error = error {
                completion(.failure(error)); return
            }
            do {
                let dto = try snap?.data(as: UserDTO.self)
                if let dto = dto {
                    completion(.success(dto))
                } else {
                    completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    func updateUser(_ user: UserDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try collection.document(user.id).setData(from: user)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
