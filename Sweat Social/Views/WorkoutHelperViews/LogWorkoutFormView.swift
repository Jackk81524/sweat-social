//
//  SwiftUIView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-04.
//

import SwiftUI

struct LogWorkoutFormView: View {
    @State var selectedSplit: Int = -1
    
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    var body: some View {
        ZStack {
            FormTemplateView(height: 450)
            
            VStack {
                Text("Log Workout")
                    .font(.system(size:22))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding()
                    .offset(y:20)
                
                VStack{
                    if(viewManagerViewModel.errorMessage != "") {
                        Text(viewManagerViewModel.errorMessage)
                            .frame(width:320)
                            .font(.system(size:18))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    ZStack {
                        FormRoundedRectangleView(height:45)
                        
                        HStack{
                            Text("Select Split to Log:")
                                .padding(2)
                            
                            Picker("Select", selection: $selectedSplit) {
                                Text("Select").tag(-1)
                                    .multilineTextAlignment(.center)
                                ForEach(viewManagerViewModel.splits.indices, id: \.self) { index in
                                    Text(viewManagerViewModel.splits[index].id)
                                        .foregroundStyle(.black)
                                        .tag(index)
                                }
                                Text("Custom").tag(viewManagerViewModel.splits.count)
                            }
                            
                        }
                        .onChange(of: selectedSplit) { _ in
                            viewManagerViewModel.errorMessage = ""
                        }
                        .frame(width: 300, height:45)
                        .padding()
                    }
                    
                        
                    if(selectedSplit == viewManagerViewModel.splits.count) {
                        AddSplitView(workouts: $viewManagerViewModel.workouts, showAddForm: $viewManagerViewModel.addSplitForm, add: viewManagerViewModel.addSplit)
                    } else {
                        ZStack {
                            FormRoundedRectangleView(height:45)
                            
                            TextField("Enter a Message to Share", text: $viewManagerViewModel.logMessage)
                                .padding()
                                .frame(width:290)
                                .onChange(of: viewManagerViewModel.logMessage) { message in
                                    if message.count > 60 {
                                        viewManagerViewModel.errorMessage = "Log message is too long."
                                    } else {
                                        viewManagerViewModel.errorMessage = ""
                                    }
                                }
                        }
                        .frame(width: 290)
                        
                        if(viewManagerViewModel.errorMessage == "" && (selectedSplit > -1 && selectedSplit < viewManagerViewModel.splits.count)) {
                            Button {
                                viewManagerViewModel.workoutsToLog = viewManagerViewModel.splits[selectedSplit].workouts
                                viewManagerViewModel.logWorkout()
                                
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 32)
                                        .foregroundColor(.black)
                                    Text("Confirm")
                                        .foregroundColor(.white)
                                        .font(.system(size:16))
                                        .fontWeight(.bold)
                                }
                                .frame(width: 141, height: 35)
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                }
                .offset(y:40)
            }
            .frame(width: 350)
            .frame(maxHeight: 450)
            //.offset(y:-150)
            
        }
        .offset(y:-75)
        .onAppear {
            viewManagerViewModel.errorMessage = ""
        }
    }
}

#Preview {
    LogWorkoutFormView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
