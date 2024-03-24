//
//  TabBarView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/14/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        ZStack {
            
            
            TabView {
                ActivityTabView()
                    .tabItem {
                        Label("Social", systemImage: "message")
                    }
                    .badge(3)
                
                Text("Calender")
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
                
                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .padding(.top, 70)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                
                Text("Sweat Social")
                    .font(.custom("Futura-MediumItalic", size: 64))
                    .fontWidth(.condensed)
                    .foregroundStyle(.white)
                    .baselineOffset(-135)
                    .bold()
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 259)
            .offset(y: -400)
            
        }
    }
}


#Preview {
    TabBar()
}
