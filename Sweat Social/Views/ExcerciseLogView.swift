//
//  ExcerciseLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import SwiftUI

struct ExcerciseLogView: View {
    let workout: WorkoutExcercise
    @Environment(\.presentationMode) var
        presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @StateObject var viewModel = ExcerciseLogViewModel()
    @State private var setDismiss = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)], spacing: 5) {
                        ForEach(viewModel.excerciseList) { excercise in
                            ExcerciseButtonView(workout: workout.id, 
                                                excercise: excercise,
                                                toDelete: $viewModel.toDelete,
                                                viewManagerViewModel: viewManagerViewModel,
                                                action: viewModel.fetchSets)
                        }
                        
                    }
                }
                
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $viewManagerViewModel.addForm,
                                       errorMessage: $viewModel.errorMessage,
                                       workoutList: $viewModel.excerciseList,
                                       mainTitle: "Add Excercise",
                                       placeHolder: "Enter Excercise",
                                       action: viewModel.addExcercise)
                    }
                }
                
                if let toDelete = viewModel.toDelete {
                    DeleteConfirmationView(toDelete: toDelete.id,
                                           toDeleteType: "excercise",
                                           update: $viewModel.deleteSuccess,
                                           delete: viewModel.deleteExcercise)
                    .onChange(of: viewModel.deleteSuccess) { _ in
                        viewModel.toDelete = nil
                    }
                    
                }
            }
            .onAppear {
                viewModel.workout = workout
                viewManagerViewModel.backButton = true
                viewManagerViewModel.title = workout.id
                viewModel.fetchExcercises()
            }
        }
        .onChange(of: viewManagerViewModel.dismiss) { _ in
            if(viewManagerViewModel.excerciseDismiss) {
                viewManagerViewModel.title = "Your Workout"
                viewManagerViewModel.backButton = false
                presentationMode.wrappedValue
                    .dismiss()
            } else {
                viewManagerViewModel.excerciseDismiss.toggle()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ExcerciseLogView(workout: WorkoutExcercise(id: "Arms", dateAdded: 3600), viewManagerViewModel: WorkoutViewManagerViewModel())
}
