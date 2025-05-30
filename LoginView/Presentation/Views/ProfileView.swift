//
//  ProfileView.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    let userId: String

    var body: some View {
        Group {
            if #available(iOS 14.0, *) {
                Form {
                    Section(header: Text("Profile")) {
                        TextField("Name", text: $viewModel.name)
                        TextField("Email", text: $viewModel.email)
                        TextField("Avatar URL", text: Binding(
                            get: { viewModel.avatarURL?.absoluteString ?? "" },
                            set: { viewModel.avatarURL = URL(string: $0) }
                        ))
                    }
                    Section {
                        if viewModel.isSaving {
                            ProgressView()
                        }
                        Button("Save") {
                            viewModel.saveChanges()
                        }
                        .disabled(viewModel.isSaving)
                        if let error = viewModel.errorMessage {
                            Text(error).foregroundColor(.red)
                        }
                    }
                }
                .navigationTitle("Profile")
                .onAppear {
                    viewModel.loadUser(id: userId)
                }
            } else {
                Text("Profile requires iOS 14 or later")
            }
        }
        .navigationTitle("Profile")
    }
}
