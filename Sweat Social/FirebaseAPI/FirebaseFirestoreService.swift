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
    static var ExerciseCollection = "Exercises"
    static var LoggedWorkouts = "Logged Workouts"
    
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
    
    func insertWorkout(userId: String,newWorkoutCategory: WorkoutExercise, newExercise: WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {

        var toAdd = newWorkoutCategory
        
        
        var doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(newWorkoutCategory.id)
        
        if let newExercise = newExercise {
            toAdd = newExercise
            doc = doc.collection(FirebaseFirestoreService.ExerciseCollection)
                .document(newExercise.id)
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
    
    func deleteWorkout(userId: String, workoutToDelete: WorkoutExercise, exerciseToDelete: WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        var doc = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workoutToDelete.id)
        
        if let exerciseToDelete = exerciseToDelete {
            doc = doc.collection(FirebaseFirestoreService.ExerciseCollection)
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

    func insertSet(userId: String, workout: String, exercise: String, reps: Int, weight: Int, completion: @escaping (Result<Void?, Error>) -> Void){
        
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExerciseCollection)
            .document(exercise)
        
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
    
    func deleteSet(userId: String, workout: String, exercise: String, index: Int, completion: @escaping (Result<Void?, Error>) -> Void){
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExerciseCollection)
            .document(exercise)
        
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
    
    func fetchWorkouts(userId: String, workout: String?, completion: @escaping (Result<[WorkoutExercise], Error>) -> Void){
        
        var collection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
        
        if let workout = workout {
            collection = collection.document(workout)
                .collection(FirebaseFirestoreService.ExerciseCollection)
        }
        
        collection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let workoutList: [WorkoutExercise] = documents.compactMap { document in
                if let id = document["id"] as? String,
                   let dateAdded = document["dateAdded"] as? TimeInterval  {
                    return WorkoutExercise(id: id, dateAdded: dateAdded)
                }
                return nil
            }
            
            completion(.success(workoutList))
        }
        
    }
    
    func fetchSets(userId: String, workout: String, exercise: String, completion: @escaping (Result<Sets?, Error>) -> Void){
        
        var sets: Sets? = nil
        
        let document = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
            .document(workout)
            .collection(FirebaseFirestoreService.ExerciseCollection)
            .document(exercise)
        
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
    
    func logWorkout(userId: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let dateAdded = Date().timeIntervalSince1970
        
        let fetchCollection = FirebaseFirestoreService.db
            .collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
         
        let logData = FirebaseFirestoreService.db.collection(FirebaseFirestoreService.userCollection)
            .document(userId)
            .collection(FirebaseFirestoreService.LoggedWorkouts)
            .document(String(dateAdded))
            .collection(FirebaseFirestoreService.WorkoutCategoriesCollection)
         
        fetchCollection.getDocuments { (fetchedData, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let documents = fetchedData?.documents else {
                completion(.failure(CustomErrors.emptyWorkout))
                return
            }
            
            var dataToLog: [[String: Any]] = []
            
            self.formatLogData(documents) { result in
                switch result {
                case .success(let data):
                    dataToLog = data
                default:
                    return
                }
                print(dataToLog)
            }
            
            //print(dataToLog)
            for data in dataToLog {
                //print(data)
                logData.addDocument(data: data) { error in
                    if let error = error {
                        print("here1")
                        completion(.failure(error))
                    } else {
                        print("here2")
                        completion(.success(()))
                    }
                }
            }
        }
    }
         
    private func formatLogData(_ fetchedData: [QueryDocumentSnapshot], completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        var formattedData: [[String: Any]] = []
        
        for document in fetchedData {
            var workoutData: [String: Any] = [:] // Initialize data for a single workout
            
            let categoryID = document.documentID
            let categoryData = document.data()
            
            workoutData["categoryID"] = categoryID
            workoutData["categoryData"] = categoryData
            
            var exercisesData: [[String: Any]] = [] // Initialize data for exercises
            
            let exercisesCollection = document.reference.collection("Exercises")
            
            exercisesCollection.getDocuments { (exercisesCollectionDocuments, error) in
                if let error = error {
                    print("Error fetching exercises:", error)
                    completion(.failure(error))
                    return // Return or handle the error
                }
                
                if let exercises = exercisesCollectionDocuments{
                    //print(exercises)
                    for exerciseDocument in exercises.documents {
                        let exerciseID = exerciseDocument.documentID
                        var exerciseData = exerciseDocument.data()
                        print(exerciseData)
                        
                        exerciseData["exerciseID"] = exerciseID
                        
                        exercisesData.append(exerciseData)
                    }
                }
                
                workoutData["exercises"] = exercisesData // Assign exercises data to workout data
                
                formattedData.append(workoutData) // Append formatted workout data to the main array
                
                // Check if this is the last document to complete formatting
                if formattedData.count == fetchedData.count {
                    completion(.success(formattedData)) // Return formatted data
                }
            }
        }
    }


}

