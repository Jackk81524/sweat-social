//
//  WorkoutLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class WorkoutLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addWorkoutForm = false
    @Published var workoutList: [WorkoutExcercise] = []
    @Published var errorMessage = ""
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    //private let workout: String?
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        //self.workout = workout
        self.userId = auth.currentUser
    }
    
    
    func addWorkout(workoutName: String) {
        guard validate(input: workoutName) else {
            return
        }
        
        let dateAdded = Date().timeIntervalSince1970
        
        let newWorkout = WorkoutExcercise(id: workoutName, dateAdded: dateAdded)
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: newWorkout, newExcercise: nil) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if error is WorkoutExists {
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
        //self.errorMessage = ""
        
    }
    
    func fetchWorkouts() {
        
        firestore.fetchWorkouts(userId: self.userId, workout: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutList):
                self?.workoutList = workoutList
            }
            
        }
    }
    
    func deleteWorkout(toDelete: WorkoutExcercise) {
        firestore.deleteWorkout(userId: self.userId, workoutToDelete: toDelete, exerciseToDelete: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                return
            }
        }
    }
    
    private func validate(input: String) -> Bool {

        guard input.count >= 3 && input.count <= 20 else {
            self.errorMessage = "Input must be between 3 and 20 characters."
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
