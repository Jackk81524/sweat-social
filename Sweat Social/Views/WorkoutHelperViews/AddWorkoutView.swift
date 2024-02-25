//
//  AddWorkoutView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct AddWorkoutView: View {
    @State private var input = ""
    @Binding var showForm: Bool
    let action: (String) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.black,lineWidth:2)                
                .background(Color.white)
                .foregroundColor(.white)
                .frame(width: 350, height: 300)
            
            VStack {
                Text("Add a workout group")
                    .font(.system(size:26))
                    .offset(y:-40)
                
                HStack {
                    Text("Enter: ")
                        .font(.system(size:22))
                        .offset(x:50)
                    
                    TextField("Add muscle group", text: $input)
                        .offset(x:100)
                        .font(.system(size:22))
                        .padding()
                        .onSubmit {
                            action(input)
                            showForm.toggle()
                        }
                }
                
            }
            
            
                    
             
            
            
                
        }
        
    }
}

#Preview {
    AddWorkoutView(showForm: .constant(true)) {_ in
        // Action
    }
}
