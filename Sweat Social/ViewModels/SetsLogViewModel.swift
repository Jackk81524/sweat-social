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
    
    
    func addSet(repsInput: Int, weightInput: Int){
        
        firestore.insertSet(userId: self.userId, workout: self.workout, excercise: self.excercise, reps: repsInput, weight: weightInput) { [weak self] result in
            guard self != nil else {
                return
            }
            
            if case let .failure(error) = result {
                    print(error.localizedDescription)
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
    
    
}

