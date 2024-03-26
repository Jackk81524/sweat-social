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
    @Published var errorMessage = ""
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        self.userId = auth.currentUser
    }
    
    
    func addSet(repsInput: String, weightInput: String){
        guard validate(input: repsInput) && validate(input: weightInput) else {
            return
        }
         
        guard let reps = Int(repsInput), let weight = Int(weightInput) else {
            return
        }
        
        firestore.insertSet(userId: self.userId, workout: self.workout, excercise: self.excercise, reps: Int(reps), weight: Int(weight)) { [weak self] result in
            guard self != nil else {
                return
            }
            
            if case let .failure(error) = result {
                self?.errorMessage = error.localizedDescription
            }
        }
        fetchSets()
    }
    
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

