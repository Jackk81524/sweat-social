//
//  TabBarView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/14/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea(edges: .top)

                Text("Sweat Social")
                    .font(.custom("Futura-MediumItalic", size: 48))
                    .fontWidth(.condensed)
                    .foregroundStyle(.white)
                    .bold()
                    .ignoresSafeArea(edges: .top)

                
            }
            .frame(height: 80)
            
            
            TabView {
                Text("Activity View")
                    .tabItem {
                        Label("Social", systemImage: "message")
                    }
                    .badge(3)
                
                Text("Calender")
                    .tabItem {
                        Label("Calender", systemImage: "calendar")
                    }
                
                
                WorkoutLogView(title: "Your Workout",
                               workoutSelected: nil,
                               addMainTitle:"Add Workout Category",
                               addPlaceHolder: "Enter workout category",
                               excercisesListed: false)
                    .tabItem {
                        Label("Log Workout", systemImage: "plus.circle.fill")
                    }
                
                GoalsView()
                    .tabItem {
                        Label("Achievements", systemImage: "medal")
                        
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
                        
        }
    }
}


#Preview {
    TabBar()
}
