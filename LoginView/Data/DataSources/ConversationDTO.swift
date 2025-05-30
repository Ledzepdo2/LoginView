//
//  AuthRepositoryProtocol.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import FirebaseFirestore

struct ConversationDTO: Codable {
    let id: String
    let participantIds: [String]  // Correct property name
    let lastMessageId: String?
    let updatedAt: Date
}

extension ConversationDTO {
    func toDomain(participants: [User], lastMessage: Message?) -> Conversation {
        Conversation(
            id: id,
            participants: participants,
            lastMessage: lastMessage,
            updatedAt: updatedAt
        )
    }
}
