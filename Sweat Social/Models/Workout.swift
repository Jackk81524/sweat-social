//
//  Workout.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import Foundation

struct WorkoutCategory: Codable {
    let name: String
    let dateAdded: TimeInterval
    var excercises: [Excercise]?
    
}

struct Excercise: Codable {
    let name: String
    let dateAdded: TimeInterval
    var sets: [Set]?
}

struct Set: Codable {
    let reps: Int?
    let weight: Double?
}
