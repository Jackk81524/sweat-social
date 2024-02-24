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
    @Published var userID = ""
    @Published var muscleGroupToAdd = ""
    @Published var addWorkoutForm = false
    init() {
        if let user = Auth.auth().currentUser {
            userID = user.uid
        } else {
            //print("error")
        }
    }
    
    func addWorkout(workoutToAdd: String) {
        
        let db = Firestore.firestore()
        
        let userData = db.collection("users").document(userID)
        
        let workoutsData = userData.collection("workouts")
        
        let workoutDoc = workoutsData.document(workoutToAdd)
        
        workoutDoc.setData(["name": workoutToAdd])
        
        
    }
    
    
}
