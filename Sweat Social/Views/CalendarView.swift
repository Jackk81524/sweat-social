//
//  CalendarView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-27.
//

import SwiftUI
import WeeklyCalendar

struct CalendarView: View {
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
        
    }
}

#Preview {
    CalendarView()
}
