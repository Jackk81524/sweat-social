//
//  FirebaseFirestoreService.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-04.
//

import Foundation
import FirebaseFirestore

// This contains the functions used to communicate with firestore
// Allows for dependency injection
// Purpose of each function should be self explanatory based on name
class FirebaseFirestoreService : FirestoreProtocol {
    static var db = Firestore.firestore()
    static var userCollection = "users"
    static var WorkoutCategoriesCollection = "Workout Categories"
    static var ExcerciseCollection = "Excercises"
    
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
    
    func fetchUser(userId: String, completion: @escaping (Result<User?, Error>) -> Void) {
        
        FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .getDocument { (documentSnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let document = documentSnapshot, document.exists,
                      let id = document["id"] as? String,
                      let name = document["name"] as? String,
                      let email = document["email"] as? String,
                      let joined = document["joined"] as? TimeInterval else {
                    completion(.success(nil))
                    return
                }
                
                let user = User(id: id, name: name, email: email, joined: joined)
                completion(.success(user))
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
            doc = doc.collection(FirebaseFirestoreService.ExcerciseCollection)
                .document(newExcercise.id)
        }
        
        doc.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let document = document, document.exists {
                completion(.failure(WorkoutExists()))
                return
            } else {
                doc.setData(toAdd.asDictionary()) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func deleteWorkout(userId: String, workoutToDelete: WorkoutExcercise, exerciseToDelete: WorkoutExcercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        var doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workoutToDelete.id)
        
        if let exerciseToDelete = exerciseToDelete {
            doc = doc.collection(FirebaseFirestoreService.ExcerciseCollection)
                .document(exerciseToDelete.id)
        }

        doc.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func insertSet(userId: String, workout: String, excercise: String, reps: Int, weight: Int, completion: @escaping (Result<Void?, Error>) -> Void){
        
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExcerciseCollection)
            .document(excercise)
        
        document.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard var setInfo = documentSnapshot?.data() else {
                print("Unknown Error")
                return
            }
            
            if var weightList = setInfo["Weight"] as? [Int], var repsList = setInfo["Reps"] as? [Int] {
                // Lists exist, append new values
                weightList.append(weight)
                repsList.append(reps)
                setInfo["Weight"] = weightList
                setInfo["Reps"] = repsList
            } else {
                // Lists don't exist, create them with the new values
                setInfo["Weight"] = [weight]
                setInfo["Reps"] = [reps]
            }
            
            document.setData(setInfo) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    func deleteSet(userId: String, workout: String, excercise: String, index: Int, completion: @escaping (Result<Void?, Error>) -> Void){
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExcerciseCollection)
            .document(excercise)
        
        document.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard var setInfo = documentSnapshot?.data() else {
                print("Unknown Error")
                return
            }
            
            if var weightList = setInfo["Weight"] as? [Int], var repsList = setInfo["Reps"] as? [Int] {
                // Lists exist, append new values
                weightList.remove(at: index)
                repsList.remove(at: index)
                
                document.setData(["Weight": weightList], merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
                
                document.setData(["Reps": repsList], merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                completion(.failure(UnknownError()))
            }
        }
    }
    
    func fetchWorkouts(userId: String, workout: String?, completion: @escaping (Result<[WorkoutExcercise], Error>) -> Void){
        
        var collection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
        
        if let workout = workout {
            collection = collection.document(workout)
                .collection(FirebaseFirestoreService.ExcerciseCollection)
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
    
    func fetchSets(userId: String, workout: String, excercise: String, completion: @escaping (Result<Sets?, Error>) -> Void){
        
        var sets: Sets? = nil
        
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExcerciseCollection)
            .document(excercise)
        
        document.addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let setInfo = documentSnapshot?.data() else {
                print("Unknown Error")
                return
            }
            
            if let reps = setInfo["Reps"] as? [Int],
               let weight = setInfo["Weight"] as? [Int] {
                sets = Sets(reps: reps,weight: weight)
            } 
            
            completion(.success(sets))
        }
        
    }
    
    func followUser(currentUserId: String, targetUserId: String, completion: @escaping (Result<Void?, Error>) -> Void) {
            let followingDocument = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
                .document(currentUserId)
                .collection("following")
                .document(targetUserId)
            
            let followersDocument = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
                .document(targetUserId)
                .collection("followers")
                .document(currentUserId)
            
            // Add the target user to the current user's "following" collection
            followingDocument.setData(["userId": targetUserId]) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Add the current user to the target user's "followers" collection
                followersDocument.setData(["userId": currentUserId]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
        
        func fetchFollowing(userId: String, completion: @escaping (Result<[String], Error>) -> Void) {
            let followingCollection = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
                .document(userId)
                .collection("following")
            
            followingCollection.getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let followingIds = querySnapshot?.documents.map { $0.documentID }
                    completion(.success(followingIds ?? []))
                }
            }
        }
    
    func searchUsersByName(query: String, completion: @escaping (Result<[User], Error>) -> Void) {
        FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .whereField("name", isGreaterThanOrEqualTo: query)
            .whereField("name", isLessThan: query + "\u{f8ff}")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let users = snapshot?.documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                }
                
                completion(.success(users ?? []))
            }
    }
    
}
