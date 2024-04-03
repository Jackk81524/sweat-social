//
//  WorkoutViewManagerViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-25.
//

import Foundation

// Variables used largely to control the header, and its associated buttons: Add and back
// No functions currently
class WorkoutViewManagerViewModel: ObservableObject {
    @Published var userId: String
    @Published var addForm = false
    @Published var title = "Your Workout"
    @Published var backButton = false
    
    @Published var dismiss = false
    @Published var exerciseDismiss = true
    @Published var errorMessage = ""
    @Published var workoutsToLog: [WorkoutExercise] = []
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    // Iniitalize firestore and auth
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    func logWorkout(){
        firestore.logSavedWorkout(userId: self.userId, workoutsToLog: workoutsToLog) { [weak self] error in
            guard self != nil else { return }
            
            if error != nil {
                if error is WorkoutExists {
                    self?.errorMessage = "You already logged a workout today."
                    return
                } else {
                    self?.errorMessage = error?.localizedDescription ?? ""
                    return
                }
            } else {
                self?.errorMessage = ""
            }
        }
    }
    
    
    
}
