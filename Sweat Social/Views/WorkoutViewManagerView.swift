//
//  WorkoutViewManagerView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-24.
//

import SwiftUI

struct WorkoutViewManagerView: View {
    @StateObject var viewManagerViewModel = WorkoutViewManagerViewModel()
    
    
    var body: some View {
        VStack {
            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
                .padding(.top,40)
            
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
