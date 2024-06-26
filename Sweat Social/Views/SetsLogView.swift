//
//  SetsWeightsView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-08.
//

import SwiftUI

// View to display the sets for an exercise
struct SetsLogView: View {
    var workout: String
    var exercise: String
    var sets: Sets?
    
    @Environment(\.presentationMode) var
        presentationMode: Binding<PresentationMode>
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @StateObject var viewModel: SetsLogViewModel
    
    init(workout: String, exercise: String, sets: Sets?, viewManagerViewModel: WorkoutViewManagerViewModel) {
        self.workout = workout
        self.exercise = exercise
        self.sets = sets
        
        self.viewManagerViewModel = viewManagerViewModel
        self._viewModel = StateObject(wrappedValue: SetsLogViewModel(userId: viewManagerViewModel.userId))
        
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Scroll view to display sets if they exist
                ScrollView {
                    if let sets = viewModel.sets {
                        // Sets are stored as two lists, one of weight and one of reps. Grab the ith index of each and display it
                        ForEach(0..<sets.weight.count, id: \.self) { index in
                            SetButtonView(reps: sets.reps[index],
                                          weight: sets.weight[index],
                                          setNum: index+1,
                                          date: $viewManagerViewModel.date,
                                          toDelete: $viewModel.toDelete)
                        }
                        
                    }
                }
                
                // Display add set popup if add button pressed
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddSetView(showAddSetForm: $viewManagerViewModel.addForm,
                                   errorMessage: $viewModel.errorMessage,
                                   setList: $viewModel.sets,
                                   action: viewModel.addSet)
                    }
                }
                
                //Display delete confirmation popup if a set is held
                if let toDelete = viewModel.toDelete {
                    DeleteConfirmationView(toDelete: String(toDelete+1),
                                           toDeleteType: "Set", update: $viewModel.deleteSuccess,
                                           delete: viewModel.deleteSet)
                    .onChange(of: viewModel.deleteSuccess) { _ in
                        viewModel.toDelete = nil
                    }
                }
                
            }
            .onAppear {
                viewModel.workout = workout
                viewModel.exercise = exercise
                viewManagerViewModel.title = exercise
                
                viewManagerViewModel.backButton = true
                viewManagerViewModel.exerciseDismiss = false
                viewModel.sets = sets
                
                
            }
            // Back button logic
            .onChange(of: viewManagerViewModel.dismiss) { _ in
                presentationMode.wrappedValue
                    .dismiss()
            }
        }
        .navigationBarHidden(true)
        
    }
        
}


#Preview {
    SetsLogView(workout: "Arms", exercise: "Curl", sets: nil, viewManagerViewModel: WorkoutViewManagerViewModel())
}
