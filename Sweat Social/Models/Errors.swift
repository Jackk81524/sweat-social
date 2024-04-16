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
    case unknownError
    case emptyWorkout
}

struct NoCurrentUser: Error {
    let message = "No current user"
}

struct EntryExists: Error {
    let message = "This entry already exists"
}

struct UnknownError: Error {
    let message = "Unknown cause of Error"
}

struct EmptyWorkout: Error {
    let message = "Your Workout is Empty"
}
