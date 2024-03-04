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
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler) {
        completion(.success(password)) // Password may seem illogical to return here, but it is serving the purpose of mocking a user id. Another option would be to generate a user id outside of this func and passing it in, and returning, but this wouldn't fit AuthProtocol
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler) {
        completion(nil)
        
    }
    
}

class MockFirebaseAuthServiceFailed: AuthProtocol {
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler) {
        let userInfo = [NSLocalizedDescriptionKey: "Failure creating user."]
        completion(.failure(NSError(domain: "RegisterError", code: 123, userInfo:userInfo)))
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping errorHandler) {
        completion(NSError(domain: "LoginError", code: 123, userInfo:nil))
    }
}

class MockFirebaseFirestoreServiceSuccess: FirestoreProtocol {
    func insertNewUser(id: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        completion(.success(()))
    }
}

class MockFirebaseFirestoreServiceFailed: FirestoreProtocol {
    func insertNewUser(id: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void) {
        let userInfo = [NSLocalizedDescriptionKey: "Failure connecting to Firestore."]
        completion(.failure(NSError(domain: "FirebaseError", code: 123, userInfo: userInfo)))
    }
}
