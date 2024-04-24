//
//  ProfileViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 3/26/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var userId: String

    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(), firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
        fetchUser(userId: userId)
    }
    
    func fetchUser(userId: String) {
        firestore.fetchUser(userId: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                self?.user = user
            }
        }
    }
    
    func followUser(targetUserId: String) {
        firestore.followUser(currentUserId: self.userId, targetUserId: targetUserId) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(_):
                print("Successfully followed user \(targetUserId)")
            }
        }
    }
    
    func fetchFollowStatus() {
        firestore.fetchFollowStatus(userId: self.userId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let followingIds):
                print("Following user IDs: \(followingIds)")
                // Update your UI based on followingIds, if needed
            }
        }
    }
}
