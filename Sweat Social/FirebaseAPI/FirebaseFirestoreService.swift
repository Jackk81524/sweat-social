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
    static var WorkoutCategoriesCollection = "Workout Categories"
    static var excerciseCollection = "Excercises"
    
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
    
    func insertWorkout(userId: String,newWorkoutCategory: WorkoutExcercise, newExcercise: WorkoutExcercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
    
        var toAdd = newWorkoutCategory
        
        var doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(newWorkoutCategory.id)
        
        if let newExcercise = newExcercise {
            toAdd = newExcercise
            doc = doc.collection(FirebaseFirestoreService.excerciseCollection)
                .document(newExcercise.id)
        }
        
        doc.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let document = document, document.exists {
                completion(.failure(WorkoutExists()))
                return
            }
        }
        
        doc.setData(toAdd.asDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchWorkouts(userId: String, workout: WorkoutExcercise?, completion: @escaping (Result<[WorkoutExcercise], Error>) -> Void){
        
        var collection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
        
        if let workout = workout {
            collection = collection.document(workout.id)
                .collection(FirebaseFirestoreService.excerciseCollection)
        }
        
        collection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let workoutList: [WorkoutExcercise] = documents.compactMap { document in
                if let id = document["id"] as? String,
                   let dateAdded = document["dateAdded"] as? TimeInterval  {
                    return WorkoutExcercise(id: id, dateAdded: dateAdded)
                }
                return nil
            }
            
            completion(.success(workoutList))
        }
        
    }
    
    /*func insertExcercise(userId: String,WorkoutExcercise: String, newExcerciseName: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let newExcercise = Excercise(name: newExcerciseName,
                                     dateAdded: Date().timeIntervalSince1970)
        
        let doc = FirebaseFirestoreService.db.collection("users")
            .document(userId)
            .collection("Workout Categories")
            .document(WorkoutExcercise)
            .collection("Excercises")
            .document(newExcerciseName)
        
        doc.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                completion(.failure(CustomErrors.existingWorkout))
            }
        }
        doc.setData(newExcercise.asDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }*/
}
