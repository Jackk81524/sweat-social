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
    let backButton: Bool
    
    @Environment(\.presentationMode) private var
        presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack{
            if(backButton){
                Button {
                    presentationMode.wrappedValue
                        .dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Text("<-")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    .frame(width: 39, height: 26)
                    .padding()
                    
                }
            }
            
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size:24))
                .padding(.leading, backButton ? 0 : UIScreen.main.bounds.width / 6)
            
            //HStack {
                //Spacer()
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
           // }
        }
    }
}

#Preview {
    WorkoutHeaderView(showAddWorkoutForm: .constant(true), title: "Your workout", backButton: true)
}
