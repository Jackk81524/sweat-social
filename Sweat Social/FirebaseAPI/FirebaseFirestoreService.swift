//
//  FirebaseFirestoreService.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-04.
//

import Foundation
import FirebaseFirestore

class FirebaseFirestoreService : FirestoreProtocol {
    static var db = Firestore.firestore()
    
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let newUser = User(id: userId,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970) // Firebase cannot store date as is, so this is a way to handle that
        
        
        FirebaseFirestoreService.db.collection("users")
            .document(userId)
            .setData(newUser.asDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    func insertWorkoutCategory(userId: String,newWorkoutCategory: WorkoutCategory, completion: @escaping (Result<Void?, Error>) -> Void) {
        
        FirebaseFirestoreService.db.collection("users")
            .document(userId)
            .collection("Workout Categories")
            .document(newWorkoutCategory.name)
            .setData(newWorkoutCategory.asDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    func insertExcercise(userId: String,workoutCategory: String, newExcerciseName: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        
        let newExcercise = Excercise(name: newExcerciseName,
                                     dateAdded: Date().timeIntervalSince1970)
        
        FirebaseFirestoreService.db.collection("users")
            .document(userId)
            .collection("Workout Categories")
            .document(workoutCategory)
            .collection("Excercises")
            .document(newExcerciseName)
            .setData(newExcercise.asDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    /*func fetchWorkouts(userId: String, currentUser: User?) {
        FirebaseFirestoreService.db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    currentUser = try document.data(as: User.self)
                    
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
    }*/
}
