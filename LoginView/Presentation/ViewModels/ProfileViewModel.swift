//
//  ProfileViewModel.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var avatarURL: URL?
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    private let fetchUserRepo: UserRepositoryProtocol
    private let updateProfileUseCase: UpdateProfileUseCase

    init(
        userRepository: UserRepositoryProtocol,
        updateProfileUseCase: UpdateProfileUseCase
    ) {
        self.fetchUserRepo = userRepository
        self.updateProfileUseCase = updateProfileUseCase
    }

    func loadUser(id: String) {
        fetchUserRepo.fetchUser(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let u):
                    self?.user = u
                    self?.name = u.name
                    self?.email = u.email
                    self?.avatarURL = u.avatarURL
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func saveChanges() {
        guard var u = user else { return }
        u.name = name
        u.email = email
        u.avatarURL = avatarURL

        isSaving = true
        errorMessage = nil

        updateProfileUseCase.execute(user: u) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSaving = false
                switch result {
                case .success:
                    self?.user = u
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
