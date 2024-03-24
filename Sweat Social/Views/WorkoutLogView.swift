//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    @Binding var addForm: Bool
    @Binding var title: String
    @Binding var backButton: Bool
    
    @StateObject var viewModel = WorkoutLogViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    ForEach(viewModel.workoutList) { group in
                        WorkoutGroupButtonView(name: group)
                    }
                }
                
                
                if addForm {
                    ZStack {
                        AddWorkoutView(showAddWorkoutForm: $addForm,
                                       mainTitle: "Add Workout",
                                       placeHolder: "Enter Workout",
                                       action: viewModel.addWorkout)
                    }
                }
            }
            //.padding(.top,40)
            .onAppear{
                viewModel.fetchWorkouts()
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    WorkoutLogView(addForm: .constant(true))
}
