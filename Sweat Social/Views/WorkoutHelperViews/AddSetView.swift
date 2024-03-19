//
//  AddSetView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-19.
//

import SwiftUI

struct AddSetView: View {
    @State private var inputWeight = ""
    @State private var inputReps = ""
    @Binding var showAddSetForm: Bool
    
    let action: (Int, Int) -> Void
    
    
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
                    .offset(y:-5)
                 
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
                            if !inputWeight.isEmpty && !inputReps.isEmpty {
                                if let intWeight = Int(inputWeight), let intReps = Int(inputReps) {
                                    action(intWeight,intReps)
                                }
                                
                            }
                            showAddSetForm.toggle()
                        }
                }
                
            }
            
      
        }
        
    }
}

#Preview {
    AddSetView(showAddSetForm: .constant(true)){_,_ in
        
    }
}
