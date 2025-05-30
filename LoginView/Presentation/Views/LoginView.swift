//
//  LoginView.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if viewModel.isLoading {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    Text("Loading...")
                }
            }
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Login") {
                viewModel.login()
            }
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}
