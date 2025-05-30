import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userSession: String?
}