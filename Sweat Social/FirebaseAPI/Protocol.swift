//
//  AuthProtocol.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-29.
//

import Foundation
import FirebaseAuth

protocol AuthProtocol {
    typealias errorHandler = (Error?) -> Void
    typealias completionHandler = (Result<String?,Error>) -> Void
    
    var currentUser: String { get }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler)
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler)
}

protocol FirestoreProtocol {
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func insertWorkout(userId: String,newWorkoutCategory: WorkoutExercise, newExercise: WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func deleteWorkout(userId: String, workoutToDelete: WorkoutExercise, exerciseToDelete: WorkoutExercise?, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func insertSet(userId: String, workout: String, exercise: String, reps: Int, weight: Int, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func deleteSet(userId: String, workout: String, exercise: String, index: Int, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func fetchWorkouts(userId: String, workout: String?, date: Date?, completion: @escaping (Result<[WorkoutExercise], Error>) -> Void)
    
    func fetchUser(userId: String, completion: @escaping (Result<User?, Error>) -> Void)
    
    func followUser(currentUserId: String, targetUserId: String, completion: @escaping (Result<Void?, Error>) -> Void)
    
    func fetchFollowStatus(userId: String, completion: @escaping (Result<[String], Error>) -> Void)
    
    func searchUsersByName(query: String, completion: @escaping (Result<[User], Error>) -> Void)

    func fetchSets(userId: String, workout: String, exercise: String, date: Date?, completion: @escaping (Result<Sets?, Error>) -> Void)

    func addSplit(userId: String, split: Split, completion: @escaping (Error?) -> Void)
        
    func deleteSplit(userId: String, splitToDelete: String, completion: @escaping (Error?) -> Void)
    
    func fetchSplits(userId: String, completion: @escaping (Result<[Split],Error>)-> Void)
    
    func logSavedWorkout(userId: String, workoutsToLog: [WorkoutExercise], logMessage: String?, splitName: String, completion: @escaping (Error?) -> Void)
    
    
    func fetchFollowing(userId: String, completion: @escaping (Result<[String], Error>) -> Void)
    
    func fetchWorkoutLog(userId: String, date: String, completion: @escaping (Result<String?, Error>) -> Void)
    
}
