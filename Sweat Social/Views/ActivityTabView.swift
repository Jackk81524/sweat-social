//
//  ActivityTabView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//

import SwiftUI

import SwiftUI

struct ActivityView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activityLogs, id: \.userId) { log in
                    NavigationLink(destination: 
                        Text("\(log.userName) just logged a workout on \(log.date)\n\(log.message)")
                    ) {
                        VStack {
                            HStack {
                                Text(log.userName)
                                    .padding(.horizontal, 4)
                                    .bold()
                                Text(log.date)
                                Spacer()
                            }
                            HStack {
                                Text(log.message)
                                    .monospaced()
                                    .padding(4)
                                Spacer()
                            }
                            
                        }
                        
                    }
                }
            }
            .navigationTitle("Activity Logs")
            .navigationBarItems(trailing: Button("Refresh") {
                viewModel.refreshActivityLogs()
            })
//            .onAppear {
//                viewModel.fetchActivityLogs()
//            }
        }
    }
}


