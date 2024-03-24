//
//  WorkoutViewManagerView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-24.
//

import SwiftUI

struct WorkoutViewManagerView: View {
    @State var addForm = false
    @State var title = "Your Workout"
    @State var backButton = false
    
    var body: some View {
        VStack {
            WorkoutHeaderView(showAddWorkoutForm: $addForm, title: title,backButton: backButton)
                .padding(.top,40)
            
            WorkoutLogView(addForm: $addForm, title: $title, backButton: $backButton)
        }
    }
}

#Preview {
    WorkoutViewManagerView()
}
