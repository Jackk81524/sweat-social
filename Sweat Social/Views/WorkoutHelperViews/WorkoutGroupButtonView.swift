//
//  WorkoutGroupButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import SwiftUI


// View for workout buttons seen on workout log screen
struct WorkoutGroupButtonView: View {
    let name: WorkoutExercise
    
    @Binding var toDelete: WorkoutExercise?
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    @State private var navigate = false
    @State private var longPress = false
    
    var body: some View {
        // Logic differentiates between a tap and hold. A tap takes you to next view. A hold asks if you want to delete
        // Label is the view for the button
        Button {
            if !self.longPress {
                self.navigate = true
            }
            self.longPress = false
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(hex: 0xF4F4F4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.black, lineWidth: 2)
                    )
                
                Text(name.id)
                    .foregroundColor(.black)
                    .font(.system(size:16))
                    .fontWeight(.bold)
                
            }
            .frame(width: 367, height: 51)
            .padding(4)
        }
        // Detect a hold on the button, trigger delete confirmation view
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.7)
                .onEnded { _ in
                    if viewManagerViewModel.date == nil {
                        self.longPress = true
                        toDelete = name
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }
        )
        .buttonStyle(PlainButtonStyle())
        
        // Navigate to next view on tap
        NavigationLink(destination: ExerciseLogView(workout: name, viewManagerViewModel: viewManagerViewModel), isActive: $navigate) {
            EmptyView()
                .frame(width:0, height: 0)
                .hidden()
        }

    }
    
}

#Preview {
    WorkoutGroupButtonView(name: WorkoutExercise(id: "Arms", dateAdded: 10.0), toDelete: .constant(WorkoutExercise(id: "Arms", dateAdded: 10.0)), viewManagerViewModel: WorkoutViewManagerViewModel())
}
