//
//  ActivityTabView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//

import SwiftUI

struct ActivityTabView: View {
    @ObservedObject private var activityViewModel = ActivityViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    ForEach(activityViewModel.users, id: \.id) { user in
                        Section(header: Text(user.name + " completed a workout")) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(formattedDate(from: user.joined))")
                                    .font(.headline)
                                Text("Burned 400 calories")
                                    .font(.body)
                            }
                        }
                    }
                }
                .navigationBarTitle("Social Activity")
                .onAppear() {
                    self.activityViewModel.fetchData()
                }
            }
        }
    }
    
    func formattedDate(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ActivityTabView()
}
