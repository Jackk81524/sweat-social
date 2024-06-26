//
//  AddWorkoutView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

// Popup view for exercise and workout screen. Takes input  variables to differentiate
struct AddWorkoutView: View {
    @State private var input = ""
    @Binding var showAddWorkoutForm: Bool
    @Binding var errorMessage: String
    @Binding var workoutList: [WorkoutExercise]
    //let workoutSelected: String?
    let mainTitle: String
    let placeHolder: String
    let action: (String) -> Void
    
    
    var body: some View {
        ZStack {
            FormTemplateView(height: 270)

            VStack {
                
                // Variable title, based on workout or exercise view
                Text(mainTitle)
                    .font(.system(size:26))
                    .foregroundStyle(.white)
                    .bold()
                    .offset(y:-40)
                
                // Perform validation and display error message if it exists
                ZStack {
                    if errorMessage != "" && errorMessage != "nil"{
                        Text(errorMessage)
                            .frame(width:300)
                            .font(.system(size:18))
                            .multilineTextAlignment(.center)
                            .offset(y:-20)
                        
                    }
                    
                    HStack {
                        Text("Enter: ")
                            .font(.system(size:22))
                            .offset(x:20)
                        
                        TextField(placeHolder, text: $input)
                            .offset(x:30)
                            .font(.system(size:22))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth:180)
                            .lineLimit(nil)
                            .padding()
                            .onSubmit {
                                action(input) // Triggers add workout, passed in from viewmodel
                            }
                            .onChange(of: workoutList.count) { _ in
                                showAddWorkoutForm.toggle() // Remove popup
                            }
                    }
                    
                    .offset(y:25)
                }
                
            }
            
      
        }
        
    }
}


#Preview {
    AddWorkoutView(showAddWorkoutForm: .constant(true), errorMessage: .constant(""), workoutList: .constant([]), mainTitle: "Enter workout", placeHolder: "Add exercise") {_ in
        //Nothing
    }
}
