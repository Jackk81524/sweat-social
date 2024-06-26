//
//  ExerciseButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-23.
//

import SwiftUI

// View of exercise button, also previews the sets
struct ExerciseButtonView: View {
    @State var sets: Sets?
    let workout : String

    let exercise: WorkoutExercise
    let date: Date?

    @Binding var toDelete: WorkoutExercise?
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @State private var navigate = false
    @State private var longPress = false
    let action: (String, Date?, @escaping (Sets?) -> Void) -> ()
    
    var body: some View {
        // Logic to trigger delete screen if held, or if tapped, go to set view
        Button{
            if !self.longPress {
                self.navigate = true
            }
            self.longPress = false
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hex:0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.black,lineWidth: 2)
                    )
                    .frame(width: 153, height: 191)
                VStack {
                    Text(exercise.id)
                        .foregroundColor(.black)
                        .font(.system(size:20))
                        //.fontWeight(.bold)
                        .padding()
                        
                    Spacer()
                    // Appropriately display sets in a preview, if they exist
                    if let sets = sets {
                        VStack{
                            if sets.reps.count == 1 {
                                Text("1 Set")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                                    .padding()
                            } else if sets.reps.count != 0{
                                Text("\(sets.reps.count) Sets")
                                    .foregroundColor(.black)
                                    .font(.system(size:16))
                                    .padding()
                            }
                       
                            ForEach(0..<min(sets.weight.count,3), id: \.self) { index in
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
                
                // Navigates to set view if button is clicked
                NavigationLink(destination: SetsLogView(workout: workout, exercise: exercise.id, sets: sets, viewManagerViewModel: viewManagerViewModel), isActive: $navigate) {
                    EmptyView()
                        .frame(width:0, height: 0)
                        .hidden()
                }
            }
            .frame(width: 153, height: 191)
            .padding(4)
        }
        .onAppear{
            // Trigger fetch on the exercises sets
            action(exercise.id, date) { result in
                sets = result
            }
            
        }
        // Logic to detetct a hold on button
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.7)
                .onEnded { _ in
                    if viewManagerViewModel.date == nil {
                        self.longPress = true
                        toDelete = exercise
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }
        )
        
        
    }
}

#Preview {
    ExerciseButtonView(workout: "Arms", exercise: WorkoutExercise(id: "Arms", dateAdded: 10.0), date: nil,
                       toDelete: .constant(WorkoutExercise(id: "Arms", dateAdded: 10.0)),
                       viewManagerViewModel: WorkoutViewManagerViewModel()) {_,_,_   in
        return
    }
}
