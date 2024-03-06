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
    
    var localizedDescription: String {
        switch self {
        case .noCurrentUser:
            return NSLocalizedString("No current user retrieved", comment: "")
        }
    }
}
