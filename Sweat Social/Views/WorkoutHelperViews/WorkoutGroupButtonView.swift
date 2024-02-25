//
//  WorkoutGroupButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI

struct WorkoutGroupButtonView: View {
    let name: String
    var body: some View {
        Button {
            // Mock
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
    }
}

#Preview {
    WorkoutGroupButtonView(name: "Test")
}
