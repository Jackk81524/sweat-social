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
    @Published var userId = ""
    
    
    private let auth: AuthProtocol
    private let firestore: FirestoreProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(), firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
    }
    
    func register() {
        guard validate() else {
            return
        }
        // Creates a user on firebase auth
        auth.createUser(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let userId):
                self?.userId = userId ?? ""
                self?.firestore.insertNewUser(id: self?.userId ?? "", name: self?.name ?? "", email: self?.email ?? "") { firestoreResult in

                    switch firestoreResult{
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    default:
                        break
                    }
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
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
