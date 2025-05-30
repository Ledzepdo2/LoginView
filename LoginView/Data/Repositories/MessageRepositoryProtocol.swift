//
//  MessageRepositoryProtocol.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import FirebaseFirestore

protocol MessageRepositoryProtocol {
    func fetchMessages(conversationId: String, completion: @escaping (Result<[Message], Error>) -> Void)
    func sendMessage(_ message: Message, completion: @escaping (Result<Void, Error>) -> Void)
    func subscribeToMessages(conversationId: String, listener: @escaping (Result<[Message], Error>) -> Void) -> ListenerRegistration
}
