//
//  AuthVM.swift
//  Bookich
//
//  Created by Sasha on 14.10.2024.
//

import Foundation
import FirebaseAuth

class AuthVM {

    func checkUser(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                }
            }
        }
    }
}
