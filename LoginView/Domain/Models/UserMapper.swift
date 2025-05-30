//
//  UserMapper.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct User: Equatable, Identifiable {
    let id: String
    var name: String
    var email: String
    var avatarURL: URL?
}
