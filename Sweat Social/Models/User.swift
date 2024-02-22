//
//  File.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-09.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
