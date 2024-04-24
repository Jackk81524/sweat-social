//
//  AchievementViewModel.swift
//  Sweat Social
//
//  Created by Luke Chigges on 4/16/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Achievement: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var isUnlocked: Bool
}

class FirestoreAchievementsService {
    @Published var userID = ""
    @Published var profilePictureURL: String = ""
    //@Published var addWorkoutForm = false
    @Published var currentUser: User?
    //@Published var workoutGroups: [WorkoutGroup]?
    private var db = Firestore.firestore()
    
    init() {
        if let user = Auth.auth().currentUser {
            userID = user.uid
        } else {
            print("Could not initialize achievement View Model. Auth failed.")
        }
    }
    
    func fetchAchievements(completion: @escaping ([Achievement]) -> Void) {
        db.collection("users").document(userID).collection("achievements").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let achievements = querySnapshot.documents.compactMap { document -> Achievement? in
                    try? document.data(as: Achievement.self)
                }
                completion(achievements)
            } else {
                print("Error fetching achievements: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func updateAchievement(_ achievement: Achievement) {
        do {
            try db.collection("users").document(userID).collection("achievements").document(achievement.id).setData(from: achievement)
        } catch let error {
            print("Error updating achievement: \(error.localizedDescription)")
        }
    }
}
