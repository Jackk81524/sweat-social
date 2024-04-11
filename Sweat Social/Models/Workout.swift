//
//  Workout.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import Foundation

struct WorkoutExercise: Codable, Identifiable {
    let id: String
    let dateAdded: TimeInterval
}

struct Split: Codable, Identifiable {
    let id: String
    let dateAdded: TimeInterval
    let workouts: [String]
}

struct Sets: Codable {
    //let id: String
    let reps: [Int]
    let weight: [Int]
}

