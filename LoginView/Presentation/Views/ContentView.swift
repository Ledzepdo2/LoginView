import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        if authManager.isLoggedIn {
            ProfileView(viewModel: ProfileViewModel(
                userRepository: FirestoreUserRepository(),
                updateProfileUseCase: UpdateProfileUseCase(
                    repository: FirestoreUserRepository()
                )
            ))
        } else {
            LoginView(viewModel: LoginViewModel(authManager: authManager))
        }
    }
}

struct UniversalBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
    }
}
