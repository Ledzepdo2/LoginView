import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userSession: String?
    @Published var currentUserId: String = ""
    
    func login(userId: String) {
        self.currentUserId = userId
        self.userSession = userId
        self.isLoggedIn = true
    }
    
    func logout() {
        self.currentUserId = ""
        self.userSession = nil
        self.isLoggedIn = false
    }
}
