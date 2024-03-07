//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    @StateObject var viewModel = WorkoutLogViewModel()
    let title: String
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        WorkoutHeaderView(showAddWorkoutForm: $viewModel.addWorkoutForm, title: title)
                        
                        ScrollView {
                            ForEach(viewModel.workoutList) { group in
                                WorkoutGroupButtonView(name: group.id)
                            }
                        }
                    }

                    if viewModel.addWorkoutForm {
                        ZStack {
                            AddWorkoutView(showAddWorkoutForm: $viewModel.addWorkoutForm, action: viewModel.addWorkout)
                        }
                    }
                    
                }
            }
            .padding(.top,40)
        }
        
    }
}

#Preview {
    WorkoutLogView(title: "Your Workout")
}
