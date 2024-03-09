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
    private let workout: String?
    
    init(workout: String?,auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.workout = workout
        self.userId = auth.currentUser
        fetchWorkouts(userId: userId,workout: workout)
    }
    
    
    func addWorkout(workoutName: String,excerciseName:String? = nil){
        let dateAdded = Date().timeIntervalSince1970
        
        let newWorkout = WorkoutExcercise(id: workoutName, dateAdded: dateAdded)
        var newExcercise: WorkoutExcercise? = nil
        
        if let excerciseName = excerciseName {
            newExcercise = WorkoutExcercise(id: excerciseName, dateAdded: dateAdded)
        }
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: newWorkout, newExcercise: newExcercise) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if error is WorkoutExists {
                    print("This workout already exists")
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchWorkouts(userId: String, workout: String? = nil) {
        
        firestore.fetchWorkouts(userId: userId, workout: workout) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutList):
                self?.workoutList = workoutList
            }
            
        }
    }
    
    
}
