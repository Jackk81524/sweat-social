//
//  TabBarView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/14/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        //AuthHeaderView()
        TabView {
            Text("Social")
                .tabItem {
                    Label("Social", systemImage: "message")
                }
                .badge(7)
            
            Text("Calender")
                .tabItem {
                    Label("Calender", systemImage: "calendar")
                }
                
            
            WorkoutLogView()
                .tabItem {
                    Label("Log Workout", systemImage: "plus.circle.fill")
                }
            
            Text("Achievements")
                .tabItem {
                    Label("Achievements", systemImage: "medal")

                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
            }
        }
    }
}


#Preview {
    TabBar()
}
