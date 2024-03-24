//
//  AddWorkoutView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-23.
//

import SwiftUI

struct AddWorkoutView: View {
    @State private var input = ""
    @Binding var showAddWorkoutForm: Bool
    //let workoutSelected: String?
    let mainTitle: String
    let placeHolder: String
    let action: (String) -> Void
    
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 16,style:.continuous)
                    .strokeBorder(Color.black,lineWidth:2)
                    .background(Color.white)
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 270)
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .circular)
                        .frame(width: 350, height: 100)
                        .foregroundStyle(.black)
                    Rectangle()
                        .frame(width:350, height: 20)
                        .foregroundStyle(.black)
                        .offset(y:40)
                }
                    
            }

            VStack {
                Text(mainTitle)
                    .font(.system(size:26))
                    .foregroundStyle(.white)
                    .bold()
                    .offset(y:-40)
                
                HStack {
                    Text("Enter: ")
                        .font(.system(size:22))
                        .offset(x:50)
                    
                    TextField(placeHolder, text: $input)
                        .offset(x:100)
                        .font(.system(size:22))
                        .padding()
                        .onSubmit {
                            action(input)
                            showAddWorkoutForm.toggle()
                        }
                }
                
            }
            
      
        }
        
    }
}


#Preview {
    AddWorkoutView(showAddWorkoutForm: .constant(true), mainTitle: "Enter workout", placeHolder: "Add excercise") {_ in 
        //Nothing
    }
}
