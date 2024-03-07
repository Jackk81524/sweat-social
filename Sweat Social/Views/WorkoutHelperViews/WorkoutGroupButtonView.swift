//
//  WorkoutGroupButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI



struct WorkoutGroupButtonView: View {
    let name: String
    @State private var showExcercise = false
    var body: some View {
        NavigationStack{
            Button {
                self.showExcercise = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(hex: 0xF4F4F4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.black,lineWidth: 2)
                                //.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        
                    
                    Text(name)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .fontWeight(.bold)
                }
                .frame(width: 367, height: 51)
                .padding(4)
            }
            /*.navigationDestination(isPresented: $showExcercise) {
                ExcerciseLogView(workoutGroup: name)
            }*/
        }
    }
}

#Preview {
    WorkoutGroupButtonView(name: "Test")
}
