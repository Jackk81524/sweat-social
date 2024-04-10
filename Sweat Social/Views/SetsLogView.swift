//
//  SetsWeightsView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-08.
//

import SwiftUI

// View to display the sets for an excercise
struct SetsLogView: View {
    let workout: String
    let excercise: String
    let sets: Sets?
    
    @Environment(\.presentationMode) var
        presentationMode: Binding<PresentationMode>
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @StateObject var viewModel = SetsLogViewModel()
    
    
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
                viewModel.excercise = excercise
                viewManagerViewModel.title = excercise
                
                viewManagerViewModel.backButton = true
                viewManagerViewModel.excerciseDismiss = false
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
    SetsLogView(workout: "Arms", excercise: "Curl", sets: nil, viewManagerViewModel: WorkoutViewManagerViewModel())
}
