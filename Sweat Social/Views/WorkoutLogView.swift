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
                            ForEach(viewModel.workoutCategories) { group in
                                WorkoutGroupButtonView(name: group.id)
                            }
                        }
                    }

                    if viewModel.addWorkoutForm {
                        ZStack {
                            AddWorkoutView(showAddWorkoutForm: $viewModel.addWorkoutForm, action: viewModel.addWorkoutCategory)
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
