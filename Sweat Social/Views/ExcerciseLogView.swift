//
//  ExcerciseLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import SwiftUI

struct ExcerciseLogView: View {
    let workout: WorkoutExcercise
    
    @StateObject var viewModel = ExcerciseLogViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)], spacing: 5) {
                        ForEach(viewModel.excerciseList) { excercise in
                            ExcerciseButtonView(workout: workout.id, excercise: excercise.id, action: viewModel.fetchSets)
                        }
                       
                    }
                }
                
                if viewModel.addExcerciseForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $viewModel.addExcerciseForm,
                                       mainTitle: "Add Excercise",
                                       placeHolder: "Enter Excercise",
                                       action: viewModel.addExcercise)
                    }
                }
            }
            .onAppear {
                viewModel.workout = workout
                viewModel.fetchExcercises()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ExcerciseLogView(workout: WorkoutExcercise(id: "Arms", dateAdded: 3600))
}
