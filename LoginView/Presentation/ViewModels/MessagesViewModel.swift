//
//  MessagesViewModel.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import Combine

final class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var draftMessage: String = ""
    @Published var isSending: Bool = false
    @Published var errorMessage: String?

    private let conversationId: String
    private let currentUser: User
    private let fetchMessagesUseCase: FetchMessagesUseCase
    private let sendMessageUseCase: SendMessageUseCase

    init(
        conversationId: String,
        currentUser: User,
        fetchMessagesUseCase: FetchMessagesUseCase,
        sendMessageUseCase: SendMessageUseCase
    ) {
        self.conversationId = conversationId
        self.currentUser = currentUser
        self.fetchMessagesUseCase = fetchMessagesUseCase
        self.sendMessageUseCase = sendMessageUseCase
        loadMessages()
    }

    func loadMessages() {
        fetchMessagesUseCase.execute(conversationId: conversationId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self?.messages = list
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func sendMessage() {
        let text = draftMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        isSending = true
        let message = Message(
            id: UUID().uuidString,
            conversationId: conversationId,
            sender: currentUser,
            content: text,
            sentAt: Date()
        )

        sendMessageUseCase.execute(message: message) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSending = false
                switch result {
                case .success:
                    self?.draftMessage = ""
                    self?.loadMessages()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
