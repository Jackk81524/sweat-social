//
//  FriendWorkoutView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-12.
//

import SwiftUI

struct FriendWorkoutView: View {
    @State var userId: String
    @StateObject var viewManagerViewModel : WorkoutViewManagerViewModel
    
    init(userId: String) {
        self.userId = userId
        self._viewManagerViewModel = StateObject(wrappedValue: WorkoutViewManagerViewModel(userId: userId))
        
    }
    
    var body: some View {
        VStack {
            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
            
            NavigationStack{
                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
            }
            
        }
        .onAppear {
            viewManagerViewModel.allowEditing = false
        }

    }
}

#Preview {
    FriendWorkoutView(userId: "1234")
}
