//
//  Errors.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-04.
//

import Foundation

struct InvalidUserError: Error {
    var localizedDescription: String = "Invalid User"
}

enum CustomErrors: Error {
    case noCurrentUser
    case existingWorkout
}

struct NoCurrentUser: Error {
    let message = "No current user"
}

struct WorkoutExists: Error {
    let message = "This workout category already exists"
}
