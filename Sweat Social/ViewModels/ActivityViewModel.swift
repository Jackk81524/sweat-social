//
//  ActivityViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//

import Foundation
import FirebaseFirestore

class ActivityViewModel: ObservableObject {
    @Published var activityLogs: [String] = []
    @Published var errorMessage: String = ""
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    private let specificDate = "2024-04-17"
    
    init(auth: AuthProtocol = FirebaseAuthService(), firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        fetchActivityLogs()
    }
    
    func fetchActivityLogs() {
        self.activityLogs = []  // Clear current logs
        let userId = auth.currentUser
        
        firestore.fetchFollowing(userId: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage = "Failed to fetch following: \(error.localizedDescription)"
            case .success(let followingUserIds):
                self?.fetchLogs(for: followingUserIds)
            }
        }
    }
    
    private func fetchLogs(for userIds: [String]) {
        let group = DispatchGroup()
        
        for userId in userIds {
            group.enter()
            firestore.fetchWorkoutLog(userId: userId, date: specificDate) { [weak self] result in
                defer { group.leave() }
                
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorMessage = "Error fetching logs: \(error.localizedDescription)"
                    }
                case .success(let logMessage):
                    if let logMessage = logMessage {
                        DispatchQueue.main.async {
                            self?.activityLogs.append(logMessage)
                        }
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            print("All logs fetched.")
        }
    }
    
    func refreshActivityLogs() {
        fetchActivityLogs()
    }
}

