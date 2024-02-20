//
//  MainViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-12.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle? // Optional
    
    // This updates the view if the users login status changes
    init() {
        try! Auth.auth().signOut()
        let handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
