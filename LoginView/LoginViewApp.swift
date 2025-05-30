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
            if #available(iOS 16.0, *) {
                NavigationStack {
                    ContentView()
                        .environmentObject(authManager)
                }
            } else {
                NavigationView {
                    ContentView()
                        .environmentObject(authManager)
                }
            }
        }
    }
}
