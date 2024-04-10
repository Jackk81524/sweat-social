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
    @Published var workouts: [WorkoutExercise] = []
    @Published var dismiss = false
    @Published var exerciseDismiss = true
    @Published var errorMessage = ""

    @Published var workoutsToLog: [String] = []
    @Published var splitsForm = false
    @Published var splits: [Split] = []
    @Published var splitToDelete = ""
    @Published var splitCancelled = false
    @Published var addSplitForm = false
    @Published var logWorkoutForm = false
    @Published var logMessage = ""
    @Published var date: Date? = nil
    @Published var calendarForm = false
    @Published var calendarButton = false
    
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
        let formattedWorkoutsToLog = workouts.filter { workout in
            return workoutsToLog.contains(workout.id)
        }

        firestore.logSavedWorkout(userId: self.userId, workoutsToLog: formattedWorkoutsToLog, logMessage: logMessage) { [weak self] error in
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
                self?.workoutsToLog = []
                self?.logMessage = ""
                self?.logWorkoutForm.toggle()
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
    
    func deleteSplit() {
        firestore.deleteSplit(userId: self.userId, splitToDelete: self.splitToDelete) { error in
            if error != nil{
                self.errorMessage = error?.localizedDescription ?? "Error entering split"
            }
            print("test")
            self.splitToDelete = ""
            
        }
    }    
}
