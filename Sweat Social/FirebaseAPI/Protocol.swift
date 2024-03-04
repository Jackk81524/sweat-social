//
//  AuthProtocol.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-29.
//

import Foundation
import FirebaseAuth

protocol AuthProtocol {
    typealias completionHandler = (Error?) -> Void
    typealias completionHandler2 = (Result<String?,Error>) -> Void
    func signIn(withEmail email: String, password: String, completion: @escaping completionHandler)
    func createUser(withEmail email: String, password: String, completion: @escaping completionHandler2)
}

protocol FirestoreProtocol {
    func insertNewUser(id: String, name: String, email: String, completion: @escaping (Result<Void?, Error>) -> Void)
}
