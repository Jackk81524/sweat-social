//
//  Workout.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import Foundation

struct WorkoutGroup: Codable, Identifiable {
    let id = UUID()
    let name: String
    var excercises: [Excercises]
}

struct Excercises: Codable, Identifiable {
    let id = UUID()
    let name: String
    var sets: [Set]?
}

struct Set: Codable {
    let reps: Int?
    let weight: Double?
}
