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
                ActivityView(viewModel: ActivityViewModel())
                    .tabItem {
                        Label("Social", systemImage: "message")
                    }
                
                CalendarView()
                    .tabItem {
                        Label("Calender", systemImage: "calendar")
                    }
                
                
                WorkoutViewManagerView()
                    .tabItem {
                        Label("Log Workout", systemImage: "plus.circle.fill")
                    }
                    
                
                GoalsView()
                    .tabItem {
                        Label("Achievements", systemImage: "medal")
                        
                    }
                
                SelfProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
                        
        }
    }
}

