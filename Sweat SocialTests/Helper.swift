//
//  Helper.swift
//  Sweat SocialTests
//
//  Created by Jack.Knox on 2024-02-28.
//

import Foundation
@testable import Sweat_Social



//struct TestHelpers {
public func generateRandomString(length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in characters.randomElement()! })
}
//}

class MockFirebaseAuthServiceSuccess: AuthProtocol {
    var currentUser: String {
        return ""
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler) {
        completion(.success(password)) // Password may seem illogical to return here, but it is serving the purpose of mocking a user id. Another option would be to generate a user id outside of this func and passing it in, and returning, but this wouldn't fit AuthProtocol
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler) {
        completion(nil)
        
    }
    
}

class MockFirebaseAuthServiceFailed: AuthProtocol {
    var currentUser: String {
        return ""
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler) {
        let userInfo = [NSLocalizedDescriptionKey: "Failure creating user."]
        completion(.failure(NSError(domain: "RegisterError", code: 123, userInfo:userInfo)))
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler) {
        completion(NSError(domain: "LoginError", code: 123, userInfo:nil))
    }
}

class MockFirebaseFirestoreServiceSuccess: FirestoreProtocol {
    func insertWorkout(userId: String, newWorkoutCategory: Sweat_Social.WorkoutExercise, newExercise: Sweat_Social.WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.success(()))
    }
    
    func deleteWorkout(userId: String, workoutToDelete: Sweat_Social.WorkoutExercise, exerciseToDelete: Sweat_Social.WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.success(()))
    }
    
    func insertSet(userId: String, workout: String, exercise: String, reps: Int, weight: Int, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.success(()))
    }
    
    func deleteSet(userId: String, workout: String, exercise: String, index: Int, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.success(()))
    }
    
    func fetchWorkouts(userId: String, workout: String?, date: Date?, completion: @escaping (Result<[Sweat_Social.WorkoutExercise], Error>) -> Void) {
        completion(.success(([])))
    }
    
    func fetchSets(userId: String, workout: String, exercise: String, date: Date?, completion: @escaping (Result<Sweat_Social.Sets?, Error>) -> Void) {
        completion(.success((nil)))
    }
    
    func addSplit(userId: String, split: Sweat_Social.Split, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func deleteSplit(userId: String, splitToDelete: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func fetchSplits(userId: String, completion: @escaping (Result<[Sweat_Social.Split], Error>) -> Void) {
        completion(.success([]))
    }
    
    func logSavedWorkout(userId: String, workoutsToLog: [Sweat_Social.WorkoutExercise], logMessage: String?, splitName: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
            completion(.success(()))
        }
}

class MockFirebaseFirestoreServiceFailed: FirestoreProtocol {
    let error = NSError(domain: "FirebaseError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Failure connecting to Firestore."])

    func insertWorkout(userId: String, newWorkoutCategory: Sweat_Social.WorkoutExercise, newExercise: Sweat_Social.WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.failure(error))
    }
    
    func deleteWorkout(userId: String, workoutToDelete: Sweat_Social.WorkoutExercise, exerciseToDelete: Sweat_Social.WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.failure(error))
    }
    
    func insertSet(userId: String, workout: String, exercise: String, reps: Int, weight: Int, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.failure(error))
    }
    
    func deleteSet(userId: String, workout: String, exercise: String, index: Int, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.failure(error))
    }
    
    func fetchWorkouts(userId: String, workout: String?, date: Date?, completion: @escaping (Result<[Sweat_Social.WorkoutExercise], Error>) -> Void) {
        completion(.failure(error))
    }
    
    func fetchSets(userId: String, workout: String, exercise: String, date: Date?, completion: @escaping (Result<Sweat_Social.Sets?, Error>) -> Void) {
        completion(.failure(error))
    }
    
    func addSplit(userId: String, split: Sweat_Social.Split, completion: @escaping (Error?) -> Void) {
        completion(error)
    }
    
    func deleteSplit(userId: String, splitToDelete: String, completion: @escaping (Error?) -> Void) {
        completion(error)
    }
    
    func fetchSplits(userId: String, completion: @escaping (Result<[Sweat_Social.Split], Error>) -> Void) {
        completion(.failure(error))
    }
    
    func logSavedWorkout(userId: String, workoutsToLog: [Sweat_Social.WorkoutExercise], logMessage: String?, splitName: String, completion: @escaping (Error?) -> Void) {
        completion(error)
    }
    
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let userInfo = [NSLocalizedDescriptionKey: "Failure connecting to Firestore."]
        completion(.failure(NSError(domain: "FirebaseError", code: 123, userInfo: userInfo)))
    }
}
