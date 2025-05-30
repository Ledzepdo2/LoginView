//
//  Constants.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

enum Constants {
    // Firebase Collections
    static let usersCollection        = "users"
    static let conversationsCollection = "conversations"
    static let messagesCollection     = "messages"
    
    // UI Text - Login
    static let usernameFieldPlaceholder = "Username"
    static let passwordFieldPlaceholder = "Password"
    static let loginButtonTitle = "Login"
    static let loadingText = "Loading..."
    static let loginSuccessMessage = "¡Inicio de sesión exitoso!"
    static let emptyCredentialsError = "Username and password cannot be empty."
    
    // UI Text - Profile
    static let profileTitle = "Profile"
    static let nameFieldPlaceholder = "Name"
    static let emailFieldPlaceholder = "Email"
    static let avatarURLFieldPlaceholder = "Avatar URL"
    static let saveButtonTitle = "Save"
    static let profileRequiresIOSText = "Profile requires iOS 14 or later"
}
