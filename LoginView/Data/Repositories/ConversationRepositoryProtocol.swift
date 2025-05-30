//
//  ConversationRepositoryProtocol.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

protocol ConversationRepositoryProtocol {
    func fetchConversations(for userId: String, completion: @escaping (Result<[Conversation], Error>) -> Void)
}
