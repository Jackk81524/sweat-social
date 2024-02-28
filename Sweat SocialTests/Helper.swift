//
//  Helper.swift
//  Sweat SocialTests
//
//  Created by Jack.Knox on 2024-02-28.
//

import Foundation


//struct TestHelpers {
public func generateRandomString(length: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map { _ in characters.randomElement()! })
}
//}
