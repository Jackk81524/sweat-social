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
                Section {
                    ForEach(viewModel.activityLogs, id: \.userId) { log in
                        NavigationLink(destination: ActivityViewMessage(log: log, viewModel: UserSearchViewModel())
                                       
                        ) {
                            VStack {
                                HStack {
                                    Text(log.userName)
                                        .padding(.horizontal, 4)
                                        .bold()
                                    Spacer()
                                    Text(log.date)
                                    
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
                } header: {
                    Text("Recent Activity")
                }

                

            }
            .navigationTitle("Activity Logs")
            .navigationBarItems(trailing: Button("Refresh") {
                viewModel.refreshActivityLogs()
            })
            .navigationBarTitleDisplayMode(.inline)
//            .onAppear {
//                viewModel.fetchActivityLogs()
//            }
        }
    }
}


struct ActivityViewMessage: View {
    var log: Log
    @ObservedObject var viewModel: UserSearchViewModel
    @StateObject var viewManagerViewModel : WorkoutViewManagerViewModel

    
    init(log: Log, viewModel: UserSearchViewModel) {
        self.log = log
        self.viewModel = viewModel
        self._viewManagerViewModel = StateObject(wrappedValue: WorkoutViewManagerViewModel(userId: log.userId))
    }

    var body: some View {
        VStack(spacing: 4) {
//            Text("\(log.userName) just logged a workout on \(log.date)\n\(log.message)")
            
            VStack(spacing: 4, content: {
                HStack {
                    Text("\(log.userName)'s Workout")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.top, .horizontal])
                
                HStack {
                    Text(log.message)
                        .font(.system(.title3, design: .monospaced))
                    Spacer()
                }
                .padding([.bottom, .horizontal])
            })
            .frame(height: 100)
            .padding(.top, -15)
            


            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
//                .padding(.top,20)
                .frame(height: 60)
            
            
            NavigationStack{
                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
            }
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxHeight: .infinity)
            
        }
        .onAppear {
            viewManagerViewModel.allowEditing = false
        }
    }
}
