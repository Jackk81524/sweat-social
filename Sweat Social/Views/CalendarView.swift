//
//  CalendarView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-10.


import SwiftUI
import WeeklyCalendar

struct CalendarView: View {

    @StateObject var viewManagerViewModel = WorkoutViewManagerViewModel()
    var body: some View {
        VStack {
            //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
            CalendarHeaderView(viewManagerViewModel: viewManagerViewModel)
                .padding(.top,40)
            
            if viewManagerViewModel.calendarForm {
                WeeklyCalendar()
                    .setColorTheme(.light)
                    .onChangeDate { selected in
                        viewManagerViewModel.date = selected
                    }
            }
            
            if(viewManagerViewModel.workouts.count == 0) {
                if let date = viewManagerViewModel.date {
                    Text("No Workouts Logged on \(dateToStringHeader(date: date))")
                        .font(.system(size:18))
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            
            NavigationStack{
                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
            }
                
        }
        .onAppear {
            viewManagerViewModel.date = .now
        }

    }
}

#Preview {
    CalendarView()
}

