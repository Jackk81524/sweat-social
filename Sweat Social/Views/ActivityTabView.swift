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
                 ForEach(viewModel.sortedDates, id: \.self) { date in
                     Section(header: Text(formatDate(date))) {
                         ForEach(viewModel.logsForDate(date)) { log in
                             NavigationLink(destination: ActivityViewMessage(log: log, viewModel: UserSearchViewModel())) {
                                 VStack(alignment: .leading) {
                                     HStack {
                                         Text(log.userName)
                                             .bold()
                                         Spacer()
                                         Text(log.splitName ?? "")
                                             .italic()
                                             .foregroundStyle(.secondary)
                                     }
                                     if (log.message == "" || log.message == " ") {
                                         Text("completed a workout")
                                             .padding(.top, 2)
                                     } else {
                                         Text(log.message)
                                             .padding(.top, 2)
                                     }
                                     
                                 }
                             }
                         }
                     }
                 }
             }
             .navigationTitle("Activity Logs")
             .navigationBarItems(trailing: Button("Refresh") {
                 viewModel.refreshActivityLogs()
             })
             .navigationBarTitleDisplayMode(.inline)
         }
     }

     private func formatDate(_ date: String) -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let date = dateFormatter.date(from: date) ?? Date()
         
         dateFormatter.dateStyle = .full
         return dateFormatter.string(from: date)
     }
}
extension ActivityViewModel {
    // Compute sorted dates from logs
    var sortedDates: [String] {
        let dates = Set(activityLogs.map { $0.date })
        return dates.sorted(by: >)
    }
    
    // Filter logs by date
    func logsForDate(_ date: String) -> [Log] {
        return activityLogs.filter { $0.date == date }
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
                        if (log.message == "" || log.message == " ") {
                            Text("completed a workout")
                                .font(.system(.title3, design: .monospaced))
                                .foregroundStyle(.indigo)
                        } else {
                            Text(log.message)
                                .font(.system(.title3, design: .monospaced))
                                .foregroundStyle(.indigo)
                        }

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
                    
                    ForEach(log.workoutCategories) { category in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(category.id)
                                    .font(.system(.title3, design: .monospaced))
                                    .foregroundStyle(.indigo)
                                Spacer()
                            }
                            .padding(.horizontal)

                            ForEach(category.exercises) { exercise in
                                
                                HStack {
                                    Text("\(exercise.id)")
                                        .padding(.leading, 32)
                                        .font(.headline)
                                        .monospaced()
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                
//                                Text("Reps: \(exercise.reps.map(String.init).joined(separator: ", "))")
//                                    .padding(.leading, 48)
//                                
//                                Text("Weights: \(exercise.weights.map(String.init).joined(separator: ", "))")
//                                    .padding(.leading, 48)
                                
                                VStack(alignment: .leading) {
                                    ForEach(0..<exercise.reps.count, id: \.self) { index in
                                        Text("Set \(index + 1): \(exercise.reps[index]) reps at \(exercise.weights[index]) lbs")
                                            .padding(.leading, 48)
                                            .monospaced()
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    
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
