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
                                    Text("Reps: \(sets.reps[index])")
                                    Text("Weight: \(sets.weight[index])")
                                }
                            }
                        }
                    }

                    if viewModel.addSetForm {
                        ZStack {
                            Text("Add")
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
