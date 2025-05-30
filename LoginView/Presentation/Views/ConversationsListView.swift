//
//  ConversationsListView.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import SwiftUI

@available(iOS 14.0, *)
struct ConversationsListView: View {
    @StateObject var viewModel: ConversationsViewModel
    let userId: String

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.conversations) { conversation in
                        NavigationLink(destination:
                            ConversationDetailView(
                                conversation: conversation,
                                currentUserId: userId
                            )
                        ) {
                            VStack(alignment: .leading) {
                                Text(conversation.participants
                                        .filter { $0.id != userId }
                                        .map { $0.name }
                                        .joined(separator: ", "))
                                    .font(.headline)
                                if let last = conversation.lastMessage {
                                    Text(last.content)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Conversations")
            .onAppear {
                viewModel.loadConversations(for: userId)
            }
        }
    }
}
