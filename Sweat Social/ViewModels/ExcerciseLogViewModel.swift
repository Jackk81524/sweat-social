//
//  ExerciseLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//View model for exercise log view
class ExerciseLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addExerciseForm = false // Controls add exercise popup
    @Published var exerciseList: [WorkoutExercise] = [] // Exercises to display
    @Published var workout: WorkoutExercise? = nil // Associated workout
    @Published var errorMessage = ""
    @Published var toDelete: WorkoutExercise? = nil // Exercise pending deletion, also controls confirmation popup
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
    
    // Adds exercise using firestore api
    func addExercise(exerciseName: String){
        // Validates input
        guard validate(input: exerciseName) else {
            return
        }
        
        let dateAdded = Date().timeIntervalSince1970
        
        let newExercise = WorkoutExercise(id: exerciseName, dateAdded: dateAdded)
        
        guard let workout = self.workout else {
            print("No workout provided.")
            return
        }
        
        firestore.insertWorkout(userId: self.userId, newWorkoutCategory: workout, newExercise: newExercise) { [weak self] result in
            guard self != nil else { return }
            
            if case let .failure(error) = result {
                if error is EntryExists {
                    self?.errorMessage = "This exercise already exists."
                } else {
                    self?.errorMessage = error.localizedDescription
                }
            } else {
                self?.errorMessage = ""
            }
        }
        
    }
    
    // Fetch exercise calling firestore api
    func fetchExercises() {
        guard let workout = self.workout else {
            print("No workout provided")
            return
        }
        
        firestore.fetchWorkouts(userId: self.userId, workout: workout.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let exerciseList):
                self?.exerciseList = exerciseList
            }
            
        }
    }
    
    // Delete exercise using firestore api
    func deleteExercise() {
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
    func fetchSets(exercise: String, completion: @escaping (Sets?) -> Void) {
        guard let workout = self.workout else {
            print("No workout provided")
            completion(nil)
            return
        }
        
        firestore.fetchSets(userId: self.userId, workout: workout.id, exercise: exercise) { result in
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
