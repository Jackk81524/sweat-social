//
//  FollowViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 4/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class FollowingViewModel: ObservableObject {
    @Published var following: [User] = []
    private var firestoreService = FirebaseFirestoreService()

    func fetchFollowing(userId: String) {
        self.following.removeAll()  // Clear the list each time before fetching new data
        firestoreService.fetchFollowing(userId: userId) { [weak self] result in
            switch result {
            case .success(let userIds):
                self?.fetchUsers(userIds: userIds)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchUsers(userIds: [String]) {
        for userId in userIds {
            firestoreService.fetchUser(userId: userId) { [weak self] result in
                switch result {
                case .success(let user):
                    if let user = user {
                        DispatchQueue.main.async {
                            self?.following.append(user)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

class FollowersViewModel: ObservableObject {
    @Published var followers: [User] = []
    private var firestoreService = FirebaseFirestoreService()

    func fetchFollowers(userId: String) {
        self.followers.removeAll()  // Clear the list each time before fetching new data
        firestoreService.fetchFollowers(userId: userId) { [weak self] result in
            switch result {
            case .success(let userIds):
                self?.fetchUsers(userIds: userIds)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchUsers(userIds: [String]) {
        for userId in userIds {
            firestoreService.fetchUser(userId: userId) { [weak self] result in
                switch result {
                case .success(let user):
                    if let user = user {
                        DispatchQueue.main.async {
                            self?.followers.append(user)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

