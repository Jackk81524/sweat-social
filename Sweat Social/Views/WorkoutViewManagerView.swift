//
//  WorkoutViewManagerView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-24.
//

import SwiftUI

// View Controller for the entire workout view stack. Constists of WorkoutView, ExcerciseView, and SetView
// Main purpose is to have one header view. Leads to better UI and also more abstracted code
struct WorkoutViewManagerView: View {
    @StateObject var viewManagerViewModel = WorkoutViewManagerViewModel()
    
    var body: some View {
        VStack {
            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
                .padding(.top,40)
            
            //Beginning of workout navigation stack, first is the Workout log view.
            NavigationStack{
                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
            }
            
            .navigationBarHidden(true)
        
        }
    }
}

#Preview {
    WorkoutViewManagerView()
}
