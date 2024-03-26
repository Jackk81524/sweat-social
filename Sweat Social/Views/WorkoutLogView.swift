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
                        WorkoutGroupButtonView(name: group,
                                               toDelete: $viewModel.toDelete,
                                               viewManagerViewModel: viewManagerViewModel)
                    }
                }
                
                
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
                
                if let toDelete = viewModel.toDelete {
                    DeleteConfirmationView(toDelete: toDelete.id,
                                           toDeleteType: "workout",
                                           update: $viewModel.deleteSuccess,
                                           delete: viewModel.deleteWorkout)
                    .onChange(of: viewModel.deleteSuccess) { _ in
                        viewModel.toDelete = nil
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
