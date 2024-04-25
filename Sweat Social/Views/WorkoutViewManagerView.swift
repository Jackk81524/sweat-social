//
//  WorkoutViewManagerView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-24.
//

import SwiftUI

// View Controller for the entire workout view stack. Constists of WorkoutView, ExerciseView, and SetView
// Main purpose is to have one header view. Leads to better UI and also more abstracted code
struct WorkoutViewManagerView: View {
    @StateObject var viewManagerViewModel = WorkoutViewManagerViewModel()
    
    var body: some View {
        VStack {
            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
                .padding(.top,25)
                .frame(height: 60)
            
            //Beginning of workout navigation stack, first is the Workout log view.
            
            ZStack {
                NavigationStack{
                    WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
                }
                
                if(viewManagerViewModel.splitsForm && viewManagerViewModel.splitToDelete == ""){
                    SplitsFormView(viewManagerViewModel: viewManagerViewModel)
                
                    
                } else if (viewManagerViewModel.splitToDelete != "") {
                    DeleteConfirmationView(toDelete: viewManagerViewModel.splitToDelete,
                                           toDeleteType: "Split",
                                           update: $viewManagerViewModel.splitCancelled,
                                           delete: viewManagerViewModel.deleteSplit)
                    .onChange(of: viewManagerViewModel.splitCancelled) { _ in
                        viewManagerViewModel.splitToDelete = ""
                    }
                }
                
                if(viewManagerViewModel.logWorkoutForm) {
                    LogWorkoutFormView(viewManagerViewModel: viewManagerViewModel)
                }
                
                Button {
                    viewManagerViewModel.logWorkoutForm.toggle()
                } label: {
                    ZStack {
                        Ellipse()
                            .foregroundColor(.black)
                        Text("Log")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                    .frame(width: 70, height: 70)
                    .padding()
                }
                .offset(x: 135, y:200)
            }
            .navigationBarHidden(true)
        
        }
        .onAppear {
            viewManagerViewModel.fetchSplits()
        }
    }
}

#Preview {
    WorkoutViewManagerView()
}
