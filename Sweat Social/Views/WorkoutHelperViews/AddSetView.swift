//
//  AddSetView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-19.
//

import SwiftUI

// Similar to add workout view, but multiple fields when adding a set
struct AddSetView: View {
    @State private var inputWeight = ""
    @State private var inputReps = ""
    @Binding var showAddSetForm: Bool
    @Binding var errorMessage: String
    @Binding var setList: Sets?
    
    let action: (String, String) -> Void
    
    
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
                Text("Add a Set")
                    .font(.system(size:26))
                    .foregroundStyle(.white)
                    .bold()
                    .offset(y:-45)
                
                ZStack {
                    // Perform input validation, display error message on failure
                    if errorMessage != "" {
                        Text(errorMessage)
                            .frame(width:320)
                            .font(.system(size:18))
                            .multilineTextAlignment(.center)
                            .offset(y:-25)
                    }
                    
                    HStack {
                        Text("Weight: ")
                            .font(.system(size:22))
                            .offset(x:50)
                        
                        TextField("Weight", text: $inputWeight)
                            .offset(x:100)
                            .font(.system(size:22))
                            .padding()
                    }
                    .offset(y:10)
                    
                    
                    HStack {
                        Text("Reps: ")
                            .font(.system(size:22))
                            .offset(x:50)
                        
                        TextField("Reps", text: $inputReps)
                            .offset(x:120)
                            .font(.system(size:22))
                            .padding()
                            .onSubmit {
                                // Only submittable if input weight and input reps are not empty
                                if !inputWeight.isEmpty && !inputReps.isEmpty {
                                        action(inputReps,inputWeight)
                                    
                                } else {
                                    errorMessage = "Please fill in both fields."
                                }
                            }
                            .onChange(of: setList?.reps.count) { _ in
                                    showAddSetForm.toggle() // dismiss popup on succesful add
                            }
                    }
                    .offset(y: 50)
                }
                    
            }
            
      
        }
        
    }
}

#Preview {
    AddSetView(showAddSetForm: .constant(true), errorMessage: .constant(""), setList: .constant(nil)){_,_ in
        
    }
}