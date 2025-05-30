//
//  AuthRepositoryProtocol.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signup(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}
