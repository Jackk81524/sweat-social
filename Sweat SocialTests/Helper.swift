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
    func signIn(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
}

class MockFirebaseAuthServiceFailed: AuthProtocol {
    func signIn(withEmail email: String, password: String, completion: @escaping (Error?) -> Void) {
        completion(NSError(domain: "LoginError", code: 123, userInfo:nil))
    }
}
