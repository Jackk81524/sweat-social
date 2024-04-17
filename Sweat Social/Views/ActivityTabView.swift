//
//  ActivityTabView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activityLogs, id: \.self) { log in
                    Text(log)
                        .padding()
                }
            }
            .navigationTitle("Activity Logs")
            .navigationBarItems(trailing: Button("Refresh") {
                viewModel.refreshActivityLogs()
            })
            .onAppear {
                viewModel.fetchActivityLogs()
            }
        }
//        .alert(isPresented: $viewModel.showError) {
//            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
//        }
    }
}

