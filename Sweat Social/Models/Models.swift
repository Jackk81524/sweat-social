//
//  Models.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import Foundation

// identifiable - unique
struct User: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var age: Int
    var weight: Double
    var height: Double
    var following: [User]
    var followers: [User]
    var achievements: [Achievement]
    var workouts: [Workout]
}

// Not unique
struct Achievement {
    let id: Int
    var title: String
    var image: URL // or var image: Data or var image: String
    var description: String
}

// Not unique
struct Workout {
    let id: Int
    var title: String
    var date: Date
    var duration: TimeInterval
    var caloriesBurned: Double
    var description: String
    var exercises: [Exercise]
    var likes: [User]
}

// Could be unique
struct Exercise {
    let id: Int
    var name: String
    var duration: TimeInterval
    var caloriesBurned: Double
    var sets: Int?
    var reps: Int?
}
