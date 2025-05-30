//
//  LoginViewApp.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import SwiftUI
import Firebase

@available(iOS 15.0, *)
@main
struct LoginViewApp: App {
    @StateObject var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if #available(iOS 14.0, *) {
                    ContentView()
                        .environmentObject(AuthManager())
                } else {
                    Text("Requires iOS 14 or later")
                }
            }
        }
    }
}
