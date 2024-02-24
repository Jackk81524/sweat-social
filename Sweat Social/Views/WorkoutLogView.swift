//
//  WorkoutLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct WorkoutLogView: View {
    @StateObject var viewModel = WorkoutLogViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ZStack{
                    
                    Text("Your Workout")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addWorkoutForm.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.black)
                                Text("+")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                            }
                            .frame(width: 39, height: 26)
                            .padding()
                            
                        }
                        
                    }
                }
                .offset(y:-340)
                    
                if viewModel.addWorkoutForm {
                    ZStack {
                        
                        
                        AddWorkoutView(showForm: $viewModel.addWorkoutForm, action: viewModel.addWorkout)
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    WorkoutLogView()
}
