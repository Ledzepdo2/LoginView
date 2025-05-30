//
//  UserRepositoryProtocol.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(id: String, completion: @escaping (Result<User, Error>) -> Void)
    func fetchUsers(userIds: [String], completion: @escaping (Result<[User], Error>) -> Void)
    func updateUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void)
}
