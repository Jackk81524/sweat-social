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
                            ForEach(viewModel.workoutList) { group in
                                WorkoutGroupButtonView(name: group)
                            }
                        }
                    }

                    if viewModel.addWorkoutForm {
                        ZStack {
                            AddWorkoutView(showAddWorkoutForm: $viewModel.addWorkoutForm,
                                           mainTitle: "Add Workout",
                                           placeHolder: "Enter Workout",
                                           action: viewModel.addWorkout)
                        }
                    }
                    
                }
            }
            .padding(.top,40)
            .onAppear{
                viewModel.fetchWorkouts()
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkoutLogView()
}
