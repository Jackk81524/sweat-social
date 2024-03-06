//
//  Workout.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import Foundation

struct WorkoutCategory: Codable, Identifiable {
    let id: String
    let dateAdded: TimeInterval
    //var excercises: [String]?
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
