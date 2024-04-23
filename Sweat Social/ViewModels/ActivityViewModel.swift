//
//  ActivityViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//
import Foundation
import FirebaseFirestore

struct Log: Identifiable {
    let date: String
    let message: String
    let userId: String
    var userName: String
    let splitName: String?
    var workoutCategories: [String] // IDs of the workout categories
    var exercisesPerCategory: [String: [String]]  // Maps each category ID to a list of exercises
    var id: String { "\(userId)_\(date)" }  // Combining userId and date for a unique identifier
}



class ActivityViewModel: ObservableObject {
    @Published var activityLogs: [Log] = []
    @Published var errorMessage: String = ""

    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol

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
                let dates = self?.lastSevenDates() ?? []
                dates.forEach { date in
                    followingUserIds.forEach { userId in
                        self?.fetchLog(for: userId, date: date)
                    }
                }
            }
        }
    }
    
    private func fetchLog(for userId: String, date: String) {
        firestore.fetchUser(userId: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching user info: \(error.localizedDescription)"
                }
            case .success(let user):
                if let user = user {
                    self?.firestore.fetchWorkoutLog(userId: userId, date: date) { result in
                        switch result {
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self?.errorMessage = "Error fetching logs: \(error.localizedDescription)"
                            }
                        case .success(let log):
                            if let log = log {
                                var updatedLog = log
                                updatedLog.userName = user.name // Populate user name
                                DispatchQueue.main.async {
                                    self?.activityLogs.append(updatedLog)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    private func lastSevenDates() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        let y1 = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let y2 = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        let y3 = Calendar.current.date(byAdding: .day, value: -3, to: today)!
        let y4 = Calendar.current.date(byAdding: .day, value: -4, to: today)!
        let y5 = Calendar.current.date(byAdding: .day, value: -5, to: today)!
        let y6 = Calendar.current.date(byAdding: .day, value: -6, to: today)!
        
        let y7 = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let y8 = Calendar.current.date(byAdding: .day, value: -8, to: today)!
        let y9 = Calendar.current.date(byAdding: .day, value: -9, to: today)!

        return [formatter.string(from: today), formatter.string(from: y1), formatter.string(from: y2), formatter.string(from: y3), formatter.string(from: y4), formatter.string(from: y5), formatter.string(from: y6), formatter.string(from: y7), formatter.string(from: y8), formatter.string(from: y9)]
    }
    
    func refreshActivityLogs() {
        fetchActivityLogs()
    }
}
