//
//  ExerciseLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import SwiftUI

// Exercise log view, displays exercises for a certain workout and gives a preview of its sets
struct ExerciseLogView: View {
    var workout: WorkoutExercise
    
    @Environment(\.presentationMode) var
        presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @StateObject var viewModel : ExerciseLogViewModel
    @State private var setDismiss = false
    
    init(workout: WorkoutExercise, viewManagerViewModel: WorkoutViewManagerViewModel) {
        self.workout = workout
        self.viewManagerViewModel = viewManagerViewModel
        self._viewModel = StateObject(wrappedValue: ExerciseLogViewModel(userId: viewManagerViewModel.userId))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // Displays the exercise buttons in two columns.
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)], spacing: 5) {
                        ForEach(viewModel.exerciseList) { exercise in
                            ExerciseButtonView(workout: workout.id, 
                                                exercise: exercise,
                                                toDelete: $viewModel.toDelete,
                                                viewManagerViewModel: viewManagerViewModel,
                                                action: viewModel.fetchSets)
                        }
                        
                    }
                }
                // Display add exercise form if button is clicked
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $viewManagerViewModel.addForm,
                                       errorMessage: $viewModel.errorMessage,
                                       workoutList: $viewModel.exerciseList,
                                       mainTitle: "Add Exercise",
                                       placeHolder: "Enter Exercise",
                                       action: viewModel.addExercise)
                    }
                }
                
                // If exercise is held, displays delete confirmation form
                if let toDelete = viewModel.toDelete {
                    DeleteConfirmationView(toDelete: toDelete.id,
                                           toDeleteType: "exercise",
                                           update: $viewModel.deleteSuccess,
                                           delete: viewModel.deleteExercise)
                    .onChange(of: viewModel.deleteSuccess) { _ in
                        viewModel.toDelete = nil // On cancel, dismiss screen
                    }
                    
                }
            }
            .onAppear { // Initialize values and exercises
                viewModel.workout = workout
                viewManagerViewModel.backButton = true
                viewManagerViewModel.title = workout.id
                viewModel.fetchExercises()
            }
        }
        // This triggers if back button is pressed. Exercise dismiss is additional logic to ensure that if the set view is dismissed, it displays exercise view, and not workout view.
        .onChange(of: viewManagerViewModel.dismiss) { _ in
            if(viewManagerViewModel.exerciseDismiss) {
                viewManagerViewModel.title = "Your Workout"
                viewManagerViewModel.backButton = false
                presentationMode.wrappedValue
                    .dismiss()
            } else {
                viewManagerViewModel.exerciseDismiss.toggle()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ExerciseLogView(workout: WorkoutExercise(id: "Arms", dateAdded: 3600), viewManagerViewModel: WorkoutViewManagerViewModel())
}
