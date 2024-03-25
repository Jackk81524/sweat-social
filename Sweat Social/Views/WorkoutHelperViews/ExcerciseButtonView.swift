//
//  ExcerciseButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import SwiftUI

struct ExcerciseButtonView: View {
    @State var sets: Sets?
    let workout : String
    let excercise: String
    
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    let action: (String, @escaping (Sets?) -> Void) -> ()
    
    var body: some View {
        NavigationLink(destination: SetsLogView(workout: workout, excercise: excercise, sets: sets, viewManagerViewModel: viewManagerViewModel)) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex:0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.black,lineWidth: 2)
                    )
                    .frame(width: 153, height: 191)
                VStack {
                    Text(excercise)
                        .foregroundColor(.black)
                        .font(.system(size:22))
                        .fontWeight(.bold)
                        .padding()
                        
                    Spacer()
                    if let sets = sets {
                        VStack{
                            if sets.reps.count == 1 {
                                Text("1 Set")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                                    .padding()
                            } else {
                                Text("\(sets.reps.count) Sets")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                                    .padding()
                            }
                       
                            ForEach(0..<min(sets.reps.count,3), id: \.self) { index in
                                Text("\(sets.weight[index]) lbs, \(sets.reps[index]) reps")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                            }
                            
                            if sets.reps.count > 3 {
                                Text("...")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                            }
                        }
                        .offset(y:-30)
                        Spacer()
                        
                    }
                }
            }
            .frame(width: 153, height: 191)
            .padding(4)
        }
        .onAppear{
            action(excercise) { result in
                sets = result
            }
        }
    }
}

#Preview {
    ExcerciseButtonView(workout: "Arms", excercise: "Barbell Curl", viewManagerViewModel: WorkoutViewManagerViewModel()) {_,_  in
        return
    }
}
