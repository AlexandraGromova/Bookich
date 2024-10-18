//
//  AuthVM.swift
//  Bookich
//
//  Created by Sasha on 14.10.2024.
//

import Foundation
import FirebaseAuth

class AuthVM {
    
    var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }

    func signInUser(email: String, password: String) {
        Task {
            do {
                let authResult = try await authService.signInUser(email: email, password: password)
                print("Успешно авторизован: \(authResult.user.uid)")
            } catch {
                print("Ошибка авторизации: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpUser(email: String, password: String) {
        Task {
            do {
                let authResult = try await authService.signUpUser(email: email, password: password)
                print("Успешно авторизован: \(authResult.user.uid)")
            } catch {
                print("Ошибка авторизации: \(error.localizedDescription)")
            }
        }
    }
}
