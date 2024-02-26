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
                        .strokeBorder(Color.black,lineWidth: 2)
                        .foregroundColor(.white)
                    
                    Text(name)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .fontWeight(.bold)
                }
                .frame(width: 367, height: 51)
                .padding(4)
            }
            .navigationDestination(isPresented: $showExcercise) {
                ExcerciseLogView(workoutGroup: name)
            }
        }
    }
}

#Preview {
    WorkoutGroupButtonView(name: "Test")
}
