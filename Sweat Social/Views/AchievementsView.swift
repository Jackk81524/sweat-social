//
//  AchievementsView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 4/15/24.
//

import SwiftUI

struct AchievementsView: View {
    @StateObject private var viewModel = AchievementsViewModel()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 20) {
                ForEach(viewModel.achievements) { achievement in
                    BadgeView(achievement: achievement)
                }
            }
            .padding()
        }
    }
}


struct BadgeView: View {
    var achievement: Achievement
    @State private var showingDetail = false  // State to control modal presentation

    var body: some View {
        Text(achievement.title)
                        .font(.headline)
                        .foregroundColor(achievement.isUnlocked ? .primary : .secondary)
                    
        Button(action: {
            showingDetail = true  // Open the modal on button tap
        }) {
            Image(systemName: achievement.isUnlocked ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
                .background(achievement.isUnlocked ? Color.yellow : Color.gray)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
        }
        .sheet(isPresented: $showingDetail) {  // Modal presentation of the detail view
            AchievementDetailView(achievement: achievement)
        }
    }
}

/*
struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(achievements: [
            Achievement(title: "Beginner", description: "Complete the tutorial", isUnlocked: true),
            Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false)
        ])
    }
}
 */

struct AchievementDetailView: View {
    var achievement: Achievement

    var body: some View {
        VStack {
            Image(systemName: achievement.isUnlocked ? "star.fill" : "star")  // Just an example; replace with your image logic
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(achievement.title)
                .font(.headline)
            Text(achievement.description)
                .font(.subheadline)
        }
        .padding()
        .navigationTitle("Achievement Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// Sample achievements data for testing
func sampleAchievements() -> [Achievement] {
    return [
        Achievement(title: "Beginner", description: "Complete the tutorial", isUnlocked: true),
        Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false),
        Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false),
        Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false),
        Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false),
        Achievement(title: "Veteran", description: "Log 100 hours of activity", isUnlocked: false),
    ]
}

#Preview {
    AchievementsView()
}
