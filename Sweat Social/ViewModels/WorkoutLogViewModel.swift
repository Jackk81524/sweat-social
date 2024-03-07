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
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        
        self.userId = auth.currentUser
        fetchWorkouts(userId: userId)
    }
    
    
    func addWorkout(workoutName: String){
        let dateAdded = Date().timeIntervalSince1970
        let newWorkout = WorkoutExcercise(id: workoutName, dateAdded: dateAdded)
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: newWorkout, newExcercise: nil) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if let customError = error as? WorkoutExists {
                    print("This workout already exists")
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchWorkouts(userId: String) {
        firestore.fetchWorkouts(userId: userId, workout: nil) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutList):
                self?.workoutList = workoutList
            }
            
        }
    }
    
    
}
