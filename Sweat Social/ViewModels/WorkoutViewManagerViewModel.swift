//
//  WorkoutViewManagerViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-25.
//

import Foundation

// Variables used largely to control the header, and its associated buttons: Add and back
// No functions currently
class WorkoutViewManagerViewModel: ObservableObject {
    @Published var addForm = false
    @Published var title = "Your Workout"
    @Published var backButton = false
    
    @Published var dismiss = false
    @Published var excerciseDismiss = true
    @Published var errorMessage = ""
    
    init() {}
    
}
