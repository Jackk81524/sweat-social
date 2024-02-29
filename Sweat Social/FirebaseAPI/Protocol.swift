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
    func signIn(withEmail email: String, password: String, completion: @escaping completionHandler)
}
