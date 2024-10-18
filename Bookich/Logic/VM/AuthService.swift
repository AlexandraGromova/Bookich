//
//  AuthService.swift
//  Bookich
//
//  Created by Sasha on 16.10.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func signUpUser(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    print("signUpUser - succses")
                    continuation.resume(returning: authResult)
                }
            }
        }
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    print("signInUser - succses")
                    continuation.resume(returning: authResult)
                }
            }
        }
    }
    
    func deleteUser(email: String, password: String) {
        
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              print("error: \(error.localizedDescription)")
            // An error happened.
          } else {
              print("Account deleted.")
            // Account deleted.
          }
        }
    }
}
