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
    Achievement(title: "Streak I", description: "Log your first split.", isUnlocked: false),
    Achievement(title: "Streak II", description: "Log a split 2 days in a row!", isUnlocked: false),
    Achievement(title: "Streak III", description: "Log a split 3 days in a row!", isUnlocked: false),
    Achievement(title: "Reps", description: "Do 100 reps of an exercise!", isUnlocked: false),
    Achievement(title: "Workout Creator", description: "Create a workout!", isUnlocked: false),
    Achievement(title: "Exercise Adept", description: "Complete a workout with 1 exercise!", isUnlocked: false),
    Achievement(title: "Exercise Warrior", description: "Complete a workout with 2 exercises!", isUnlocked: false),
    Achievement(title: "Exercise Master", description: "Complete a workout with 3 or more exercises!", isUnlocked: false),
]

class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []

    private var service = FirestoreAchievementsService()

    init() {
        fetchAchievements()
    }

    func fetchAchievements() {
        service.checkAndUnlockAchievement()
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
    @Published var splits: [Split] = []
    @Published var exerciseList: [WorkoutExercise] = []
    @Published var workout: WorkoutExercise? = nil
    @Published var activityLogs: [Log] = []
    @Published var errorMessage: String = ""
    @Published var workoutList: [WorkoutExercise] = []
    private var db = Firestore.firestore()
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService(),
         userId: String? = nil) {
        self.auth = auth
        self.firestore = firestore
        
        if let userId = userId {
            self.userID = userId
        } else {
            self.userID = auth.currentUser
        }
    }
    
    func fetchAchievements(completion: @escaping ([Achievement]) -> Void) {
        checkAndUnlockAchievement()
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
    
    func fetchSplits() {
        firestore.fetchSplits(userId: self.userID) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let splits):
                self?.splits = splits
                print(splits)
            }
        }
    }
    
    func fetchSets(exercise: String, date: Date?, completion: @escaping (Sets?) -> Void) {
        guard let workout = self.workout else {
            print("No workout provided")
            completion(nil)
            return
        }
        
        firestore.fetchSets(userId: self.userID, workout: workout.id, exercise: exercise, date: date) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sets):
                completion(sets)
            }
        }
    }
    
    func fetchExercises(date: Date?) {
        guard let workout = self.workout else {
            print("No workout provided")
            return
        }
        
        firestore.fetchWorkouts(userId: self.userID, workout: workout.id, date: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let exerciseList):
                self?.exerciseList = exerciseList
            }
            
        }
    }
    
    func fetchWorkouts(date: Date?) {
        
        firestore.fetchWorkouts(userId: self.userID, workout: nil, date: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutList):
                self?.workoutList = workoutList
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
    
    private func lastSevenDates() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = Date()
        // Last 2 Weeks
        return (0...13).map { formatter.string(from: Calendar.current.date(byAdding: .day, value: -$0, to: today)!) }
    }
    
    func countLoggedWorkouts(completion: @escaping (Int) -> Void) {
        let workoutsCollection = Firestore.firestore().collection("users").document(self.userID).collection("Logged Workouts")
        
        workoutsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(-1) // Indicate an error or no data
            } else {
                if let count = querySnapshot?.documents.count {
                    print("Number of workouts logged: \(count)")
                    completion(count) // Pass the count to the completion handler
                } else {
                    completion(0) // No documents found, return count as 0
                }
            }
        }
    }

    
    func checkAndUnlockAchievement() {
        
        // Initialize their achievements
        self.initializeAchievementsForUser(userId: self.userID)
        
        let achievementsCollection = db.collection("users").document(self.userID).collection("achievements")
        
        // Fetch achievements that are related to hours logged and are still locked
        achievementsCollection.whereField("isUnlocked", isEqualTo: false).whereField("title", in: ["Streak I", "Streak II", "Streak III"])
            .getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                
                self.fetchWorkouts(date: Date())
                print(self.workoutList)
                
                if(self.workoutList.count >= 1) {
                    self.workout = self.workoutList[0]
                    self.fetchExercises(date: Date())
                    print(self.exerciseList)
                }
                
                self.countLoggedWorkouts { count in
                    for document in documents {
                        guard let achievement = try? document.data(as: Achievement.self) else {
                            continue
                        }
                        
                        // Check if the current hours meet the criteria for unlocking the achievement
                        // Query database for workout logs
                        print("Checking if achievement should be unlocked:")
                        print(achievement)
                        if ((achievement.title == "Streak I" && count >= 1) ||
                            (achievement.title == "Streak II" && count >= 2) ||
                            (achievement.title == "Streak III" && count >= 3) ||
                            (achievement.title == "Workout Creator" && self.workoutList.count >= 2) ||
                            (achievement.title == "Exercise Adept" && self.exerciseList.count >= 1) ||
                            (achievement.title == "Exercise Warrior" && self.exerciseList.count >= 2) ||
                            (achievement.title == "Exercise Master" && self.exerciseList.count >= 3)) {
                            
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
}
