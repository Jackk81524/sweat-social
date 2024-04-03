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
    @Published var splitsForm = false
    @Published var splits: [Split] = []
    
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
                if error is EntryExists {
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
    
    func fetchSplits() {
        firestore.fetchSplits(userId: self.userId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let splits):
                self?.splits = splits
            }
             
        }
    }
    
    func addSplit(split: Split) {
        firestore.addSplit(userId: self.userId, split: split) { error in
            if error != nil{
                if error is EntryExists {
                    self.errorMessage = "This split already exists"
                } else {
                    self.errorMessage = error?.localizedDescription ?? "Error entering split"
                }
            }
        }
    }
    
    
    
}
