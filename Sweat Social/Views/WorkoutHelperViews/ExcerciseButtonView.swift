//
//  ExcerciseButton.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI

struct ExcerciseButtonView: View {
    let name: String
    var body: some View {
        Button {
            // Mock
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(Color.black,lineWidth: 2)
                    .foregroundColor(.white)
                
                VStack {
                    Text(name)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Reps: 12")
                            .foregroundColor(.black)
                            .font(.system(size:12))
                            .fontWeight(.bold)
                        Text("Weight: 45")
                            .foregroundColor(.black)
                            .font(.system(size:12))
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Text("Reps: 8")
                            .foregroundColor(.black)
                            .font(.system(size:12))
                            .fontWeight(.bold)
                        Text("Weight: 60")
                            .foregroundColor(.black)
                            .font(.system(size:12))
                            .fontWeight(.bold)
                    }                }
                
                
            }
            .frame(width: 367, height: 80)
            .padding(4)
        }
    }
}

#Preview {
    ExcerciseButtonView(name: "Curl")
}
