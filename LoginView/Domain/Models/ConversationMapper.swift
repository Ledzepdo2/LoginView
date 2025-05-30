//
//  ConversationMapper.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct Conversation: Equatable, Identifiable {
    let id: String
    let participants: [User]
    var lastMessage: Message?
    var updatedAt: Date
}
