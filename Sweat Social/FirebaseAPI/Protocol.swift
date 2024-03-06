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
    
    var currentUser: String? { get }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler)
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler)
}

protocol FirestoreProtocol {
    func insertNewUser(userId: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void)
    func insertWorkoutCategory(userId: String,newWorkoutName: String, completion: @escaping (Result<Void?, Error>) -> Void)
    func insertExcercise(userId: String,workoutCategory: String, newExcerciseName: String, completion: @escaping (Result<Void?, Error>) -> Void)
}

