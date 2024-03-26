//
//  WorkoutGroupButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI



struct WorkoutGroupButtonView: View {
    let name: WorkoutExcercise
    
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    let action: (WorkoutExcercise) -> Void

    var body: some View {
        NavigationLink(destination: ExcerciseLogView(workout: name, viewManagerViewModel: viewManagerViewModel))
        {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(hex: 0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.black, lineWidth: 2)
                    )
                
                Text(name.id)
                    .foregroundColor(.black)
                    .font(.system(size:16))
                    .fontWeight(.bold)
                
                
            }
            .frame(width: 367, height: 51)
            .padding(4)
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button styling
        
    }
    
}

#Preview {
    WorkoutGroupButtonView(name: WorkoutExcercise(id: "Arms", dateAdded: 10.0) , viewManagerViewModel: WorkoutViewManagerViewModel()) { _ in
    //
    }
}
