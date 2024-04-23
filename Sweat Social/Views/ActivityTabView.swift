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
                    ForEach(viewModel.activityLogs) { log in
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
        VStack(spacing: 6) {
            ScrollView {
                HStack {
                    Text("\(log.userName)'s Workout")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                Divider()
                
                VStack(spacing: 8, content: {
                    HStack {
                        Text("Logged Message")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(log.message)
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(.indigo)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                })
                .padding(.bottom)
                
                Divider()
                VStack(spacing: 8, content: {
                    HStack {
                        Text("Split Name")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text(log.splitName ?? "-")
                            .font(.system(.title3, design: .monospaced))
                            .foregroundStyle(.indigo)
                        Spacer()
                    }
                    .padding(.horizontal)
                })
                .padding(.bottom)
                
                Divider()
                VStack(spacing: 8, content: {
                    HStack {
                        Text("Workout Details")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ForEach(log.workoutCategories, id: \.self) { category in
                        HStack {
                            Text(category)
                                .font(.title3)
                                .foregroundStyle(.indigo)
                            Spacer()
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading) {
                            ForEach(log.exercisesPerCategory[category] ?? [], id: \.self) { exer in
                                HStack {
                                    Text("- \(exer)")
                                        .padding(.leading, 32)
                                    Spacer()
                                }
                               
                            }
                        }

                    }
                    .padding(.bottom, 2)
                    
                })
                .padding(.bottom)
            

                Spacer()
            }



//            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
//            WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
////                .padding(.top,20)
//                .frame(height: 60)
//            
//            
//            NavigationStack{
//                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
//            }
//            .frame(width: UIScreen.main.bounds.width)
//            .frame(maxHeight: .infinity)
            
        }
        .onAppear {
            viewManagerViewModel.allowEditing = false
        }
    }
}
