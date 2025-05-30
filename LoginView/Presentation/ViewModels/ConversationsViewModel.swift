//
//  ConversationsViewModel.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import Combine

final class ConversationsViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let fetchConversationsUseCase: FetchConversationsUseCase

    init(fetchConversationsUseCase: FetchConversationsUseCase) {
        self.fetchConversationsUseCase = fetchConversationsUseCase
    }

    func loadConversations(for userId: String) {
        isLoading = true
        errorMessage = nil
        fetchConversationsUseCase.execute(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let list):
                    self?.conversations = list
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
