//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    @StateObject var viewModel = WorkoutLogViewModel()
    
    var body: some View {
        NavigationStack {
            AuthButtonView(title: "test") {
                viewModel.addWorkout(workoutToAdd: "arms")
            }
        }
    }
}

#Preview {
    WorkoutLogView()
}
