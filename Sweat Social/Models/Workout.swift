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

/*struct Exercise: Codable {
    let id: String
    let dateAdded: TimeInterval
    //var sets: [Set]?
}*/

struct Sets: Codable {
    //let id: String
    let reps: [Int]
    let weight: [Int]
}

