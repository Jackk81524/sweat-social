//
//  UserSearchViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 4/8/24.
//

import Foundation
import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserSearchViewModel: ObservableObject {
    @Published var searchQuery = "" {
        didSet {
            self.performSearch(query: searchQuery)
        }
    }
    @Published var searchResults: [User] = []
    @Published var followingUserIds: Set<String> = []


    private var firestoreService = FirebaseFirestoreService()
    
    func performSearch(query: String) {
        guard !query.isEmpty else {
            self.searchResults = []
            return
        }
        
        firestoreService.searchUsersByName(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.searchResults = users
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.searchResults = []
                }
            }
        }
    }
    
    func followUser(_ targetUserId: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        firestoreService.followUser(currentUserId: currentUserId, targetUserId: targetUserId) { result in
            switch result {
            case .success:
                print("Followed user successfully")
            case .failure(let error):
                print("Error following user: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchFollowing() {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
            firestoreService.fetchFollowing(userId: userId) { [weak self] result in
                switch result {
                case .success(let followingIds):
                    self?.followingUserIds = Set(followingIds)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }



}
