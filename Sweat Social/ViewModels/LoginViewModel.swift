//
//  File.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import Foundation
import FirebaseAuth


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService()) {
        self.auth = auth
    }
    
    func login() {
        guard validate() else {
            return
        }
        
        // Try login
        // This throws User doesnt exist message upon failure, but doesn't actually check error message
        // At the time, this was too complex, and should be fixed as the app develops
        auth.signIn(withEmail: email, password: password) { (error) in
            if error != nil {
                self.errorMessage = "User does not exist"
            }
        }
    }
    
    // Validates login info entered
    private func validate() -> Bool {
        errorMessage = ""
        // Ensures no blank fields
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all fields."
            return false
        }
        // Makes sure email has the @ and . chars
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
    }
}
