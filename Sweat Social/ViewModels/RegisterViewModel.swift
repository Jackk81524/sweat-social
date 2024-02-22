//
//  RegisterViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        // Creates a user on firebase auth
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    // Adds user info to firestore, doesn't include password for security reasons
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970) // Firebase cannot store date as is, so this is a way to handle that
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    // Validates registration input
    private func validate() -> Bool {
        // Makes sure no blank fields
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        //Makes sure email has @ and . chars
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        // Makes sure password is at least 6 chars
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return false
        }
        // Password and confirm passwrod entries must be equal
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return false
        }
        
        return true
        
    }
}
