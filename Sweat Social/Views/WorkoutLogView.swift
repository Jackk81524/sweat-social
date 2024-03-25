//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @StateObject var viewModel = WorkoutLogViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView {
                    ForEach(viewModel.workoutList) { group in
                        WorkoutGroupButtonView(name: group, viewManagerViewModel: viewManagerViewModel)
                    }
                }
                
                
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $viewManagerViewModel.addForm,
                                       mainTitle: "Add Workout",
                                       placeHolder: "Enter Workout",
                                       action: viewModel.addWorkout)
                    }
                }
            }
            .onAppear{
                viewModel.fetchWorkouts()
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkoutLogView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
