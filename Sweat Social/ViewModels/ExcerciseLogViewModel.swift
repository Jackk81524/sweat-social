//
//  ExcerciseLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//View model for excercise log view
class ExcerciseLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addExcerciseForm = false // Controls add excercise popup
    @Published var excerciseList: [WorkoutExcercise] = [] // Excercises to display
    @Published var workout: WorkoutExcercise? = nil // Associated workout
    @Published var errorMessage = ""
    @Published var toDelete: WorkoutExcercise? = nil // Excercise pending deletion, also controls confirmation popup
    @Published var deleteSuccess = false // dismisses popup
    
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    // Initilize firebase auth and firestore
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    // Adds excercise using firestore api
    func addExcercise(excerciseName: String){
        // Validates input
        guard validate(input: excerciseName) else {
            return
        }
        
        let dateAdded = Date().timeIntervalSince1970
        
        let newExcercise = WorkoutExcercise(id: excerciseName, dateAdded: dateAdded)
        
        guard let workout = self.workout else {
            print("No workout provided.")
            return
        }
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: workout, newExcercise: newExcercise) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if error is WorkoutExists {
                    self?.errorMessage = "This excercise already exists."
                } else {
                    self?.errorMessage = error.localizedDescription
                }
            } else {
                self?.errorMessage = ""
            }
        }
        
    }
    
    // Fetch exercise calling firestore api
    func fetchExercises(date: Date?) {
        guard let workout = self.workout else {
            print("No workout provided")
            return
        }
        
        firestore.fetchWorkouts(userId: self.userId, workout: workout.id, date: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let excerciseList):
                self?.excerciseList = excerciseList
            }
            
        }
    }
    
    // Delete excercise using firestore api
    func deleteExcercise() {
        guard let toDelete = toDelete, let workout = workout else {
            return
        }
        
        firestore.deleteWorkout(userId: self.userId, workoutToDelete: workout, exerciseToDelete: toDelete) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                self?.toDelete = nil
                return
            }
        }
    }
    
    // Fetch sets using firestore api
    func fetchSets(exercise: String, date: Date?, completion: @escaping (Sets?) -> Void) {
        guard let workout = self.workout else {
            print("No workout provided")
            completion(nil)
            return
        }
        
        firestore.fetchSets(userId: self.userId, workout: workout.id, exercise: exercise, date: date) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sets):
                completion(sets)
            }
        }
    }
    
    // Private func to validate input
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
