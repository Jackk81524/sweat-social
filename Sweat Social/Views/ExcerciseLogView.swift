//
//  ExcerciseLogView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI

struct ExcerciseLogView: View {
    @StateObject var viewModel = ExcerciseLogViewModel()
    let workoutGroup : String
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView {
                        if let excercises = viewModel.excercises {
                            ForEach(excercises) { group in
                                ExcerciseButtonView(name: group.name)
                            }
                            .offset(y:50)
                        }
                    }
                }
                
                ZStack{
                    
                    Text(workoutGroup)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addExcerciseForm.toggle()
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
                        .padding(8)
                        
                    }
                }
                .offset(y:-340)

                if viewModel.addExcerciseForm {
                    ZStack {
                        AddExcerciseView(showForm: $viewModel.addExcerciseForm, action: viewModel.addExcercise)
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    ExcerciseLogView(workoutGroup: "Legs")
}
