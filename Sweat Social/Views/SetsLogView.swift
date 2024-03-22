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
    
    
    @StateObject var viewModel = SetsLogViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        WorkoutHeaderView(showAddWorkoutForm: $viewModel.addSetForm, title: "Sets")
                        
                        ScrollView {
                            if let sets = viewModel.sets {
                                
                                ForEach(0..<sets.reps.count, id: \.self) { index in
                                    SetButtonView(reps: sets.reps[index], weight: sets.weight[index], setNum: index+1)
                                }
                            }
                        }
                    }

                    if viewModel.addSetForm {
                        ZStack {
                            AddSetView(showAddSetForm: $viewModel.addSetForm, action: viewModel.addSet) 
                        }
                    }
                    
                }
                .onAppear {
                    viewModel.workout = workout
                    viewModel.excercise = excercise
                    viewModel.fetchSets()
                }
            }
            .padding(.top,40)
        }
        .navigationBarHidden(true)
        
        
    }
}


#Preview {
    SetsLogView(workout: "Arms", excercise: "Curl")
}
