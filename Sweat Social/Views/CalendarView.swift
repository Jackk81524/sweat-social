//
//  CalendarView.swift
//  Sweat Social
//
<<<<<<< Updated upstream
//  Created by Jack.Knox on 2024-03-27.
=======
//  Created by Jack.Knox on 2024-04-10.
>>>>>>> Stashed changes
//

import SwiftUI
import WeeklyCalendar

struct CalendarView: View {
<<<<<<< Updated upstream
    @State var selectedDate: Date = .now
    //@StateObject var viewManagerViewModel = WorkoutViewManagerViewModel()
    
    var body: some View {
        VStack {
            WeeklyCalendar()
                .onChangeDate { date in
                    selectedDate = date
                }
                .setColorTheme(.custom(bgColor: .white))
                .padding(.top,40)
                
                
            
            WorkoutViewManagerView(padding: 0)
                //.offset(y:-80)
            
            

        }
        
=======
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
            
            NavigationStack{
                WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
            }
                
        }
        .onAppear {
            viewManagerViewModel.date = .now
        }
>>>>>>> Stashed changes
    }
}

#Preview {
    CalendarView()
}
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
