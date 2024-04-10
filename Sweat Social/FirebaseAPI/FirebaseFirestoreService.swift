//
//  FirebaseFirestoreService.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-04.
//

import Foundation
import FirebaseFirestore
//import Util

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
    
<<<<<<< Updated upstream
    func fetchWorkouts(userId: String, workout: String?, completion: @escaping (Result<[WorkoutExcercise], Error>) -> Void){
=======
    func fetchWorkouts(userId: String, workout: String?, date: Date?, completion: @escaping (Result<[WorkoutExercise], Error>) -> Void){
        
>>>>>>> Stashed changes
        
        var doc = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
<<<<<<< Updated upstream
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
=======
        
        if let date = date {
            doc = doc.collection(FirebaseFirestoreService.LoggedWorkouts)
                .document(dateToString(date: date))
        }
        
        var collection = doc.collection(FirebaseFirestoreService.WorkoutCategoriesCollection)

>>>>>>> Stashed changes
        
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
    
<<<<<<< Updated upstream
    func fetchSets(userId: String, workout: String, excercise: String, completion: @escaping (Result<Sets?, Error>) -> Void){
=======
    func fetchSets(userId: String, workout: String, exercise: String, date: Date?, completion: @escaping (Result<Sets?, Error>) -> Void){
>>>>>>> Stashed changes
        
        var sets: Sets? = nil
        
        var document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
<<<<<<< Updated upstream
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExcerciseCollection)
            .document(excercise)
=======
        
        if let date = date {
            document = document.collection(FirebaseFirestoreService.LoggedWorkouts)
                .document(dateToString(date: date))
        }
        document = document.collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
                    .document(workout)
                    .collection(FirebaseFirestoreService.ExerciseCollection)
                    .document(exercise)
>>>>>>> Stashed changes
        
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
    
<<<<<<< Updated upstream
=======
    func addSplit(userId: String, split: Split, completion: @escaping (Error?) -> Void) {
        var doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.Splits)
            .document(split.id)
        
        doc.getDocument { (document, error) in
            if let error = error {
                completion(error)
                return
            } else if let document = document, document.exists {
                completion(EntryExists())
                return
            } else {
                doc.setData(split.asDictionary()) { error in
                    if let error = error {
                        completion(error)
                    }
                }
            }
        }
    }
    
    func deleteSplit(userId: String, splitToDelete: String, completion: @escaping (Error?) -> Void){
        let doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.Splits)
            .document(splitToDelete)
        
        doc.delete { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchSplits(userId: String, completion: @escaping (Result<[Split],Error>)-> Void){
        var collection = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.Splits)
        
        collection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let splitsList: [Split] = documents.compactMap { document in
                if let id = document["id"] as? String,
                   let dateAdded = document["dateAdded"] as? TimeInterval,
                   let workouts = document["workouts"] as? [String] {
                    return Split(id: id, dateAdded: dateAdded, workouts: workouts)
                }
                return nil
            }
            
            completion(.success(splitsList))
        }
    }
    
    func logSavedWorkout(userId: String, workoutsToLog: [WorkoutExercise], logMessage: String?, completion: @escaping (Error?) -> Void) {
        let dateLogged = Date()
        
        let logDoc = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.LoggedWorkouts)
            .document(dateToString(date: dateLogged))
        
        workoutsToLog.forEach { workout in
            logWorkout(logCollection: logDoc.collection(FirebaseFirestoreService.WorkoutCategoriesCollection), workout: workout, userId: userId) { error in
                completion(error)
            }
        }
        
        if let logMessage = logMessage {
            let formattedMessage: [String: String] = [
                "logMessage": logMessage
            ]
            
            logDoc.setData(formattedMessage) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func logWorkout(logCollection: CollectionReference, workout: WorkoutExercise, userId: String, completion: @escaping (Error?) -> Void) {
        
        let currentDoc = logCollection.document(workout.id)
        
        currentDoc.getDocument { (document, error) in
            if let error = error {
                completion(error)
                return
            } else if let document = document, document.exists {
                completion(EntryExists())
            } else {
                currentDoc.setData(workout.asDictionary()) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        self.logExercise(workout: workout,
                                         userId: userId,
                                         logCollection: currentDoc.collection(FirebaseFirestoreService.ExerciseCollection)) { error in
                            if error != nil {
                                completion(error)
                            } else{
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Different than other fetch because it does not add snapshot listener, it musts fetches documents a single time
    // Purpose is for logging. "singleFetch" intended to mean fetch once, rather than adding listener
    private func logExercise(workout: WorkoutExercise, userId: String, logCollection: CollectionReference, completion: @escaping (Error?) -> Void) {
        let fetchCollection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout.id)
            .collection(FirebaseFirestoreService.ExerciseCollection)

        fetchCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            let exerciseList: [WorkoutExercise] = documents.compactMap { document in
                if let id = document["id"] as? String,
                   let dateAdded = document["dateAdded"] as? TimeInterval  {
                    return WorkoutExercise(id: id, dateAdded: dateAdded)
                }
                return nil
            }
            
            exerciseList.forEach { exercise in
                var logDoc = logCollection.document(exercise.id)
                logDoc.getDocument { (document, error) in
                    if let error = error {
                        completion(error)
                    } else if let document = document, document.exists {
                        // Continue
                    } else {
                        logDoc.setData(exercise.asDictionary()) { error in
                            if let error = error {
                                completion(error)
                            } else {
                                self.logSets(fetchDocument: fetchCollection.document(exercise.id), logDocument: logDoc) { error in
                                    if error != nil{
                                        completion(error)
                                    } else {
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func logSets(fetchDocument: DocumentReference, logDocument: DocumentReference, completion: @escaping (Error?) -> Void) {
        var sets: Sets? = nil
        
        fetchDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(error)
            }
            
            guard let setInfo = documentSnapshot?.data() else {
                print("Unknown Error")
                return
            }
            
            if let reps = setInfo["Reps"] as? [Int],
               let weight = setInfo["Weight"] as? [Int] {
                sets = Sets(reps: reps,weight: weight)
            }
            
            logDocument.getDocument { (documentSnapshot, error) in
                if let error = error {
                    completion(error)
                }
                
                guard var setInfo = documentSnapshot?.data() else {
                    completion(UnknownError())
                    return
                }
                
                if let sets = sets {
                    setInfo["Weight"] = sets.weight
                    setInfo["Reps"] = sets.reps
                }
                
                logDocument.setData(setInfo) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
>>>>>>> Stashed changes
}
