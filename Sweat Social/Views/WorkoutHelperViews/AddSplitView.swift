//
//  AddSplitView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-03.
//

import SwiftUI

struct AddSplitView: View {
    @State var splitName = ""
    @State var selectedIndex: Int = -1
    @State var selectedWorkouts: [String] = []
    
    @Binding var workouts: [WorkoutExercise]
    @Binding var showAddForm: Bool
    let add: (Split) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.black, lineWidth: 2)
                    )
                
                TextField("Split Name (Optional)", text: $splitName)
                    .padding()
            }
            .frame(width: 300, height: 55)
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.black, lineWidth: 2)
                    )
                    .frame(width:300,height:55)
                HStack{
                    Text("Add to Split:")
                    
                    Picker("Select", selection: $selectedIndex) {
                        Text("Select Workout").tag(-1)
                            .multilineTextAlignment(.center)
                        ForEach(0 ..< workouts.count) { index in
                            if !selectedWorkouts.contains(where: { $0 == workouts[index].id}) {
                                Text(workouts[index].id)
                                    .foregroundStyle(.black)
                                    .tag(index)
                            }
                        }
                    }
                    .onChange(of: selectedIndex) { idx in
                        if(idx != -1){
                            selectedWorkouts.append(workouts[idx].id)
                        }
                        selectedIndex = -1
                    }
                    
                }
                .frame(width: 300, height:45)
            }
            
            if(selectedWorkouts.count > 0){
                Text("Your Split:")
                    .foregroundStyle(.black)
                    .font(.system(size:20))
                    .bold()
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5),GridItem(.flexible(), spacing: 5)], spacing: 5) {
                    ForEach(selectedWorkouts, id: \.self) { workout in
                        Text(workout)
                            .foregroundStyle(.black)
                            .font(.system(size:18))
                            .padding(.top,5)
                    }
                    
                }
                
                Button {
                    if(splitName == ""){
                        splitName = selectedWorkouts.joined(separator: "-")
                    }
                    
                    let newSplit = Split(id: splitName, dateAdded: Date().timeIntervalSince1970, workouts: selectedWorkouts)
                    
                    add(newSplit)
                    showAddForm.toggle()
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
               
            }
            //.offset(y:50)

        }
    }
}

#Preview {
    AddSplitView(workouts: .constant([]), showAddForm: .constant(false)) { _ in
    //
    }
}
