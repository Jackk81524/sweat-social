//
//  SetsLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-19.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class SetsLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addSetForm = false
    @Published var workout: String = ""
    @Published var excercise: String = ""
    @Published var sets: Sets? = nil
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    
    /*func addWorkout(workoutName: String,excerciseName:String? = nil){
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
    }*/
    
    func fetchSets() {
        firestore.fetchSets(userId: self.userId, workout: self.workout, excercise: self.excercise) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sets):
                self?.sets = sets
            }
        }
    }
    
    
}

