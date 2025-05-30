//
//  MessageDTO.swift
//  MessageDTO
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct MessageDTO: Codable {
    let id: String
    let conversationId: String
    let senderId: String
    let content: String
    let sentAt: Date
}

extension MessageDTO {
    func toDomain(sender: User) -> Message {
        Message(
            id: id,
            conversationId: conversationId,
            sender: sender,
            content: content,
            sentAt: sentAt
        )
    }
}
