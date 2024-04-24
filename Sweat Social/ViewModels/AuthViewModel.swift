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
    //@Published var firstSignIn: Bool

    // This updates the view if the users login status changes
    init() {
        
       do {
            try Auth.auth().signOut()
       } catch _ as NSError {
            //Catch
       }
        
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }

    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
