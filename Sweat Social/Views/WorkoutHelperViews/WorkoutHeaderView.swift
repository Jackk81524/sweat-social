//
//  WorkoutHeaderView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-05.
//

import SwiftUI

struct WorkoutHeaderView: View {
    @Binding var showAddWorkoutForm: Bool
    let title: String
    
    var body: some View {
        ZStack{
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                Spacer()
                Button {
                    showAddWorkoutForm.toggle()
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
    }
}

#Preview {
    WorkoutHeaderView(showAddWorkoutForm: .constant(true), title: "Your workout")
}
