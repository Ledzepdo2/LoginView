//
//  ConversationDetailView.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import SwiftUI

@available(iOS 14.0, *)
struct ConversationDetailView: View {
    let conversation: Conversation
    let currentUserId: String
    @StateObject private var viewModel: MessagesViewModel

    init(
        conversation: Conversation,
        currentUserId: String,
        fetchUseCase: FetchMessagesUseCase = FetchMessagesUseCase(repository: FirestoreMessageRepository()),
        sendUseCase: SendMessageUseCase = SendMessageUseCase(repository: FirestoreMessageRepository())
    ) {
        self.conversation = conversation
        self.currentUserId = currentUserId
        _viewModel = StateObject(wrappedValue:
            MessagesViewModel(
                conversationId: conversation.id,
                currentUser: conversation.participants.first { $0.id == currentUserId } ?? conversation.participants[0],
                fetchMessagesUseCase: fetchUseCase,
                sendMessageUseCase: sendUseCase
            )
        )
    }

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                List(viewModel.messages) { message in
                    HStack {
                        if message.sender.id == currentUserId {
                            Spacer()
                            Text(message.content)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        } else {
                            Text(message.content)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            Spacer()
                        }
                    }
                    .id(message.id)
                }
                .onChange(of: viewModel.messages) { _ in
                    if let last = viewModel.messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            HStack {
                TextField("Message...", text: $viewModel.draftMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    viewModel.sendMessage()
                }
                .disabled(viewModel.isSending || viewModel.draftMessage.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
}
