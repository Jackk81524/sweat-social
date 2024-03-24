//
//  ExcerciseLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ExcerciseLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addExcerciseForm = false
    @Published var excerciseList: [WorkoutExcercise] = []
    @Published var workout: WorkoutExcercise? = nil
    
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    
    func addExcercise(excerciseName: String){
        let dateAdded = Date().timeIntervalSince1970
        
        let newExcercise = WorkoutExcercise(id: excerciseName, dateAdded: dateAdded)
        
        guard let workout = self.workout else {
            print("No workout provided")
            return
        }
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: workout, newExcercise: newExcercise) { [weak self] result in
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
    
    func fetchExcercises() {
        guard let workout = self.workout else {
            print("No workout provided")
            return
        }
        
        firestore.fetchWorkouts(userId: self.userId, workout: workout.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let excerciseList):
                self?.excerciseList = excerciseList
            }
            
        }
    }
    
    func fetchSets(excercise: String, completion: @escaping (Sets?) -> Void) {
        guard let workout = self.workout else {
            print("No workout provided")
            completion(nil)
            return
        }
        
        firestore.fetchSets(userId: self.userId, workout: workout.id, excercise: excercise) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sets):
                completion(sets)
            }
        }
    }
    
}
