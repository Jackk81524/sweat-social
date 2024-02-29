//
//  FirebaseAuthService.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-29.
//

import Foundation
import FirebaseAuth


class FirebaseAuthService: AuthProtocol {
    func signIn(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                completion(error)
        }
    }
}
