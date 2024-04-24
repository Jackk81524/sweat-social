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

let defaultAchievements: [Achievement] = [
    Achievement(title: "The Beginning", description: "Create a Sweat Social account", isUnlocked: true),
    Achievement(title: "Logging I", description: "Log your first activity.", isUnlocked: false),
    Achievement(title: "Logging II", description: "Log 2 activities", isUnlocked: false),
    Achievement(title: "Logging III", description: "Log 3 activities", isUnlocked: false),
]

class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []

    private var service = FirestoreAchievementsService()

    init() {
        fetchAchievements()
    }

    func fetchAchievements() {
        service.fetchAchievements { [weak self] achievements in
            DispatchQueue.main.async {
                self?.achievements = achievements
            }
        }
    }
}

class FirestoreAchievementsService {
    @Published var userID = ""
    @Published var profilePictureURL: String = ""
    @Published var currentUser: User?
    private var db = Firestore.firestore()
    
    init() {
        if let user = Auth.auth().currentUser {
            userID = user.uid
        } else {
            print("Could not initialize achievement View Model. Auth failed.")
        }
    }
    
    func fetchAchievements(completion: @escaping ([Achievement]) -> Void) {
        checkAndUnlockAchievement(userId: userID)
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
    
    func initializeAchievementsForUser(userId: String) {
        let achievementsCollection = db.collection("users").document(userId).collection("achievements")
        
        achievementsCollection.getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                if querySnapshot.documents.isEmpty {
                    // No achievements exist, initialize default achievements
                    self.createDefaultAchievements(for: userId, in: achievementsCollection)
                }
            } else if let error = error {
                print("Error checking achievements: \(error.localizedDescription)")
            }
        }
    }
    
    private func createDefaultAchievements(for userId: String, in achievementsCollection: CollectionReference) {
        let achievements = defaultAchievements
        for achievement in achievements {
            do {
                let _ = try achievementsCollection.document(achievement.id).setData(from: achievement)
            } catch let error {
                print("Error initializing achievement: \(error.localizedDescription)")
            }
        }
    }
    
    func countLoggedWorkouts(userId: String, completion: @escaping (Int?, Error?) -> Void) {
        let workoutsCollection = Firestore.firestore().collection("users").document(userId).collection("Logged Workouts")
        
        workoutsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                let count = querySnapshot?.documents.count
                print("Number of workouts logged: \(count ?? 0)")
                completion(count, nil)
            }
        }
    }

    
    func checkAndUnlockAchievement(userId: String) {
        let achievementsCollection = db.collection("users").document(userId).collection("achievements")
        
        // Fetch achievements that are related to hours logged and are still locked
        achievementsCollection.whereField("isUnlocked", isEqualTo: false).whereField("title", in: ["Logging I", "Logging II", "Logging III"])
            .getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Fetch logged workouts
                let workoutCount: Int? = 0
                countLoggedWorkouts(userId: userID, completion: workoutCount)

                

                
                //let workoutModel = WorkoutLogViewModel()
                //workoutModel.fetchWorkouts(date: nil)
                
                
                for document in documents {
                    guard let achievement = try? document.data(as: Achievement.self) else {
                        continue
                    }
                    
                    // Check if the current hours meet the criteria for unlocking the achievement
                    // Query database for workout logs
                    print("Checking if achievement should be unlocked.")
                    if (achievement.title == "Logging I" && workoutModel.workoutList.count >= 1) ||
                       (achievement.title == "Logging II" && workoutModel.workoutList.count >= 2) ||
                       (achievement.title == "Logging III" && workoutModel.workoutList.count >= 3) {
                        
                        // Update the achievement to unlocked
                        print("Unlocking achievement.")
                        var updatedAchievement = achievement
                        updatedAchievement.isUnlocked = true
                        do {
                            try achievementsCollection.document(document.documentID).setData(from: updatedAchievement)
                        } catch let error {
                            print("Error updating achievement: \(error.localizedDescription)")
                        }
                    }
                }
            }
    }

}
