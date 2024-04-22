//
//  CalendarHeaderView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-10.
//

import SwiftUI

struct CalendarHeaderView: View {
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    var body: some View {
        HStack{
            // Checks to see if back button should be displayed. WorkoutLog will not have it, as it is the first screen
            // View for back button
            if(viewManagerViewModel.backButton){
                Button {
                    viewManagerViewModel.dismiss.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            //.fontWeight(.bold)
                    }
                    .frame(width: 39, height: 26)
                    .padding()
                    
                }
                
            }
                
            // Displays title in top center of the screen. Controller by viewManagerViewModel
            VStack{
                Text(viewManagerViewModel.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size:24))
                    .multilineTextAlignment(.center)
                
                Text(dateToStringHeader(date: viewManagerViewModel.date ?? Date()))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size:18))
                    .multilineTextAlignment(.center)
            }
            .padding(.trailing, !viewManagerViewModel.backButton ? 0 : UIScreen.main.bounds.width / 6)
            .padding(.leading, viewManagerViewModel.backButton ? 0 : UIScreen.main.bounds.width / 6)
            
            if !viewManagerViewModel.backButton {
                Button {
                    viewManagerViewModel.calendarForm.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 45, height: 36)
                .padding()
            }
        }
    }
}

#Preview {
    CalendarHeaderView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
