//
//  FirebaseAuthService.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-29.
//

import Foundation
import FirebaseAuth


class FirebaseAuthService: AuthProtocol {    
    var currentUser: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            completion(error)
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<String?,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let userId = result?.user.uid {
                completion(.success(userId))
            } else {
                completion(.failure(InvalidUserError()))
            }
        }
    }
}
