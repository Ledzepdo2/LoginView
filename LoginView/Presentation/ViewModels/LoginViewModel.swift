//
//  LoginViewModel.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    @Published var successMessage: String?

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Username and password cannot be empty."
            return
        }
        isLoading = true
        errorMessage = nil
        successMessage = nil

        loginUseCase.execute(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isLoggedIn = true
                    self?.successMessage = "¡Inicio de sesión exitoso!"
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
