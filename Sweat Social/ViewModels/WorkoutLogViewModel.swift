//
//  WorkoutLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class WorkoutLogViewModel: ObservableObject {
    @Published var userId: String
    @Published var addWorkoutForm = false
    @Published var workoutCategories: [WorkoutCategory] = []
    
    private let firestore: FirestoreProtocol
    private let auth: AuthProtocol
    
    init(auth: AuthProtocol = FirebaseAuthService(),
         firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
        
        self.userId = auth.currentUser
        fetchWorkoutCategories(userId: userId)
    }
    
    
    func addWorkoutCategory(workoutCategoryName: String){
        let dateAdded = Date().timeIntervalSince1970
        let newWorkoutCategory = WorkoutCategory(id: workoutCategoryName, dateAdded: dateAdded)
        
        firestore.insertWorkoutCategory(userId: self.userId, newWorkoutCategory: newWorkoutCategory) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                self.workoutCategories.append(newWorkoutCategory)
                return
            }
        }
    }
    
    func fetchWorkoutCategories(userId: String) {
        firestore.fetchWorkoutCategories(userId: userId) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let workoutCategories):
                self?.workoutCategories = workoutCategories
            }
            
        }
    }
    
    
}
