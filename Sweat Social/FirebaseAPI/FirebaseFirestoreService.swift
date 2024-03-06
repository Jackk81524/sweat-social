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
    static var userCollection = "users"
    static var workoutCategoryCollection = "Workout Categories"
    
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let newUser = User(id: userId,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970) // Firebase cannot store date as is, so this is a way to handle that
        
        
        FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
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
        
        FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.workoutCategoryCollection)
            .document(newWorkoutCategory.id)
            .setData(newWorkoutCategory.asDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    func fetchWorkoutCategories(userId: String, completion: @escaping (Result<[WorkoutCategory], Error>) -> Void){
        
        let workoutCategoryCollection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.workoutCategoryCollection)
        
        workoutCategoryCollection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let workoutCategories: [WorkoutCategory] = documents.compactMap { document in
                if let id = document["id"] as? String,
                   let dateAdded = document["dateAdded"] as? TimeInterval  {
                    return WorkoutCategory(id: id, dateAdded: dateAdded)
                }
                return nil
            }
            
            completion(.success(workoutCategories))
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
}
