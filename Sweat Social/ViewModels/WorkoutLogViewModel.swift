//
//  WorkoutLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// View model for workout log view
class WorkoutLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addWorkoutForm = false // Controls add workout popup
    @Published var workoutList: [WorkoutExercise] = [] // List of workouts
    @Published var errorMessage = ""
    @Published var toDelete: WorkoutExercise? = nil // Workout pending deletion, also controls popup
    @Published var deleteSuccess = false // Helps control deletion confirm popup
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    // Iniitalize firestore and auth
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    // Add workout
    func addWorkout(workoutName: String) {
        guard validate(input: workoutName) else {
            return
        }
        
        let dateAdded = Date().timeIntervalSince1970
        
        let newWorkout = WorkoutExercise(id: workoutName, dateAdded: dateAdded)
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: newWorkout, newExercise: nil) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if error is EntryExists {
                    self?.errorMessage = "This workout already exists."
                    return
                } else {
                    self?.errorMessage = error.localizedDescription
                    return
                }
            } else {
                self?.errorMessage = ""
            }
        }
        
    }
    
    func fetchWorkouts(date: Date?) {
        
        firestore.fetchWorkouts(userId: self.userId, workout: nil, date: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutList):
                self?.workoutList = workoutList
            }
            
        }
    }
    
    func deleteWorkout() {
        guard let toDelete = toDelete else {
            return
        }
        
        firestore.deleteWorkout(userId: self.userId, workoutToDelete: toDelete, exerciseToDelete: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                self?.toDelete = nil
                return
            }
        }
    }
    
    private func validate(input: String) -> Bool {

        guard input.count >= 3 && input.count <= 30 else {
            self.errorMessage = "Input must be between 3 and 30 characters."
            return false
            
        }
        
        let allowedCharacterSet = CharacterSet.letters.union(.whitespaces)
        guard input.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil else {
            self.errorMessage = "Invalid characters in input."
            return false
        }

        
        return true
        
    }
    
    
}
