//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

// This is the main workout category log view.
struct WorkoutLogView: View {
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel // viewModel to control header
    
    @StateObject var viewModel: WorkoutLogViewModel // viewModel to manage workout log
    
    init(viewManagerViewModel: WorkoutViewManagerViewModel) {
        self.viewManagerViewModel = viewManagerViewModel
        self._viewModel = StateObject(wrappedValue: WorkoutLogViewModel(userId: viewManagerViewModel.userId))
        
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Create a scroll view of workout buttons
                ScrollView {
                    ForEach(viewModel.workoutList) { group in
                        WorkoutGroupButtonView(name: group,
                                               toDelete: $viewModel.toDelete,
                                               viewManagerViewModel: viewManagerViewModel)
                        
                    }
                }
                
                // Check to see if add form is clicked, and display form if so
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $viewManagerViewModel.addForm,
                                       errorMessage: $viewModel.errorMessage,
                                       workoutList: $viewModel.workoutList,
                                       mainTitle: "Add Workout",
                                       placeHolder: "Enter Workout",
                                       action: viewModel.addWorkout)
                    }
                }
                
                // Check to see if delete is enabled, and show confirm screen if so
                if let toDelete = viewModel.toDelete {
                    DeleteConfirmationView(toDelete: toDelete.id,
                                           toDeleteType: "workout",
                                           update: $viewModel.deleteSuccess,
                                           delete: viewModel.deleteWorkout)
                    .onChange(of: viewModel.deleteSuccess) { _ in
                        viewModel.toDelete = nil // This removes popup if cancel is pressed
                    }
                    
                }
            }
            .onAppear{
                viewModel.fetchWorkouts()
            }
            .onChange(of: viewModel.workoutList.count) { _ in
                viewManagerViewModel.workouts = viewModel.workoutList
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkoutLogView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
