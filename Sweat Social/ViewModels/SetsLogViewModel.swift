//
//  SetsLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-19.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore


//View model for set view
class SetsLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addSetForm = false // Var to trigger add set popup
    @Published var workout: String = "" // Workout associated with the set
    @Published var exercise: String = "" // Exercise associated with the set
    @Published var sets: Sets? = nil // Sets to display in view
    @Published var errorMessage = ""
    @Published var toDelete: Int? = nil // If delete is triggered, this value is updated, which displays confirmation view
    @Published var deleteSuccess = false // Used to dismiss delete popup
    @Published var firstFetch = true // Used to minimize number of calls to firestore, pass in sets from exercise view, and initialize snapshot on first add or delete
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    // Initialize firestore and firebase auth
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService(),
         userId: String? = nil) {
        self.auth = auth
        self.firestore = firestore
        
        if let userId = userId {
            self.userId = userId
        } else {
            self.userId = auth.currentUser
        }
    }
    
    // Logic to add a set
    func addSet(repsInput: String, weightInput: String){
        // Makes sure set is valid
        guard validate(input: repsInput) && validate(input: weightInput) else {
            return
        }
        // Makes sure input is integers
        guard let reps = Int(repsInput), let weight = Int(weightInput) else {
            return
        }
        // Calls firestore to add set
        firestore.insertSet(userId: self.userId, workout: self.workout, exercise: self.exercise, reps: Int(reps), weight: Int(weight)) { [weak self] result in
            guard self != nil else {
                return
            }
            
            // Error handling
            if case let .failure(error) = result {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = ""
            }
        }
        if firstFetch {
            fetchSets()
        }
    }
    
    // Calls firestore api to delete set
    func deleteSet() {
        guard let toDelete = toDelete else {
            return
        }
        
        firestore.deleteSet(userId: self.userId, workout: self.workout, exercise: self.exercise, index: toDelete) { [weak self] result in
            guard self != nil else {
                return
            }
            
            if case let .failure(error) = result {
                print(error.localizedDescription)
            } else {
                self?.toDelete = nil
            }
        }
        if firstFetch {
            fetchSets()
        }
    }
    
    // Calls firestore api to fetch sets
    func fetchSets() {
        firestore.fetchSets(userId: self.userId, workout: self.workout, exercise: self.exercise) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sets):
                self?.sets = sets
            }
        }
    }
    
    // Validates input, sets error message if invalid
    private func validate(input: String) -> Bool {
        guard input.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil else {
            self.errorMessage = "Only numeric characters allowewd."
            return false
        }
        
        guard input.count <= 3 else {
            self.errorMessage = "Input must be at most a 3 digit number."
            return false
        }
        
        return true
        
    }
    
    
}

