//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    let title: String
    let workoutSelected: String?
    let addMainTitle: String
    let addPlaceHolder: String
    let excercisesListed: Bool
    
    @StateObject var viewModel : WorkoutLogViewModel
    
    init(title: String, workoutSelected: String?, addMainTitle: String, addPlaceHolder: String, excercisesListed: Bool) {
        self.title = title
        self.workoutSelected = workoutSelected
        self.addMainTitle = addMainTitle
        self.addPlaceHolder = addPlaceHolder
        self.excercisesListed = excercisesListed
        self._viewModel = StateObject(wrappedValue: WorkoutLogViewModel(workout: workoutSelected))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        WorkoutHeaderView(showAddWorkoutForm: $viewModel.addWorkoutForm, title: title)
                        
                        ScrollView {
                            ForEach(viewModel.workoutList) { group in
                                WorkoutGroupButtonView(name: group.id, excercisesListed: self.excercisesListed)
                            }
                        }
                    }

                    if viewModel.addWorkoutForm {
                        ZStack {
                            AddWorkoutView(showAddWorkoutForm: $viewModel.addWorkoutForm, workoutSelected: workoutSelected, mainTitle: addMainTitle, placeHolder: addPlaceHolder, action: viewModel.addWorkout)
                        }
                    }
                    
                }
            }
            .padding(.top,40)
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkoutLogView(title: "Your Workout", workoutSelected: nil, addMainTitle: "Enter workout", addPlaceHolder: "Add Excercise", excercisesListed: false)
}
