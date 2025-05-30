//
//  MessageMapper.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct Message: Equatable, Identifiable {
    let id: String
    let conversationId: String
    let sender: User
    let content: String
    let sentAt: Date
}
