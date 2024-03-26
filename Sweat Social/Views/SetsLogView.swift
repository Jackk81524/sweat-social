//
//  SetsWeightsView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-08.
//

import SwiftUI

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
                ScrollView {
                    if let sets = viewModel.sets {
                        
                        ForEach(0..<sets.weight.count, id: \.self) { index in
                            SetButtonView(reps: sets.reps[index],
                                          weight: sets.weight[index],
                                          setNum: index+1,
                                          toDelete: $viewModel.toDelete)
                        }
                        
                    }
                }
                
                if viewManagerViewModel.addForm {
                    ZStack {
                        AddSetView(showAddSetForm: $viewManagerViewModel.addForm,
                                   errorMessage: $viewModel.errorMessage,
                                   setList: $viewModel.sets,
                                   action: viewModel.addSet)
                    }
                }
                
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
