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
    
    @StateObject var viewModel = SetsLogViewModel()
    
    
    var body: some View {
        ZStack {
            ScrollView {
                if let sets = viewModel.sets {
                    
                    ForEach(0..<sets.reps.count, id: \.self) { index in
                        SetButtonView(reps: sets.reps[index], weight: sets.weight[index], setNum: index+1)
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
            viewModel.sets = sets
        }
        .navigationBarHidden(true)
    }
        
}


#Preview {
    SetsLogView(workout: "Arms", excercise: "Curl", sets: nil)
}
