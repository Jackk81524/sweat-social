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
            VStack {
                ZStack {
                    VStack {
                        WorkoutHeaderView(showAddWorkoutForm: $viewModel.addWorkoutForm, title: "Your Workout")
                        
                        ScrollView {
                            if let workoutGroups = viewModel.workoutGroups {
                                ForEach(workoutGroups) { group in
                                    WorkoutGroupButtonView(name: group.name)
                                }
                                
                            }
                        }
                    }

                    if viewModel.addWorkoutForm {
                        ZStack {
                            AddWorkoutView(showAddWorkoutForm: $viewModel.addWorkoutForm, action: viewModel.addWorkoutGroup)
                        }
                    }
                    
                }
            }
            .padding(.top,40)
        }
        
    }
}

#Preview {
    WorkoutLogView()
}
