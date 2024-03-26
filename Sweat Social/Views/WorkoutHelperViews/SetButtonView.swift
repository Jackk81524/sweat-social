//
//  SetButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-19.
//

import SwiftUI

struct SetButtonView: View {
    let reps: Int
    let weight: Int
    let setNum: Int
    
    @Binding var toDelete: Int?
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: 0xF4F4F4))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.black, lineWidth: 2)
                )
                .frame(width: 367, height: 90)
                //.padding(4)

            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width:50, height: 90)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width:70, height: 90)
                        .offset(x: 20)
                    
                    Text("\(setNum)")
                        .foregroundStyle(.white)
                        .font(.system(size:36))
                        .offset(x:10)
                    
                }
                Spacer()
            }
        }
        .overlay(
            VStack {
                HStack {
                    Text("Weight: \(weight)")
                        .font(.system(size:20))
                    
                }
                .padding(2)
                HStack {
                    Text("Reps: \(reps)")
                        .font(.system(size:20))
                }
                .padding(2)
            }
        )
        .padding(2)
        .onLongPressGesture(minimumDuration: 0.7) {
            toDelete = setNum-1
        }

        
    }
}

#Preview {
    SetButtonView(reps: 10, weight: 10, setNum: 1, toDelete: .constant(nil))
}
