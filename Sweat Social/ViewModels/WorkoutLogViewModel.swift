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
    @Published var currentUser: User?
    @Published var workoutGroups: [WorkoutGroup]?
    private var db = Firestore.firestore()
    
    init() {
        if let user = Auth.auth().currentUser {
            userID = user.uid
            fetchWorkoutGroups()
        } else {
            //print("error")
        }
    }
    
    func fetchWorkoutGroups() {
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    self.currentUser = try document.data(as: User.self)
                    
                    if let workoutGroups = self.currentUser?.workout {
                        self.workoutGroups = workoutGroups
                    }
                } catch {
                    print(error)
                }
            } else {
                print("Document does not exist")
                return
            }
        }
    }
    
    func addWorkoutGroup(workoutGroupName: String){
        fetchWorkoutGroups()
        let newWorkoutGroup = WorkoutGroup(name: workoutGroupName, excercises: [])
        
        var workoutGroupsDicts: [[String: Any]] = []
        if var workoutGroups = workoutGroups {
            for group in workoutGroups {
                workoutGroupsDicts.append(group.asDictionary())
            }
            workoutGroups.append(newWorkoutGroup)
            self.workoutGroups = workoutGroups
            
        }
        
        
        
        workoutGroupsDicts.append(newWorkoutGroup.asDictionary())
        
        let workoutGroupsData = ["workout": workoutGroupsDicts]
        db.collection("users").document(userID).updateData(workoutGroupsData)
            
    }
    
    
}
