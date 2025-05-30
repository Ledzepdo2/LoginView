import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        if authManager.isLoggedIn {
            ProfileView(viewModel: ProfileViewModel(
                userRepository: FirestoreUserRepository(),
                updateProfileUseCase: UpdateProfileUseCase(
                    repository: FirestoreUserRepository()
                )
            ), userId: authManager.currentUserId)
        } else {
            LoginView()
                .environmentObject(LoginViewModel(
                    loginUseCase: LoginUseCase(
                        authRepository: FirestoreAuthRepository()
                    )
                ))
        }
    }
}

struct UniversalBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
    }
}
