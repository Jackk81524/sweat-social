//
//  WorkoutHeaderView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-05.
//

import SwiftUI

struct WorkoutHeaderView: View {
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
            Text(viewManagerViewModel.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size:24))
                .padding(.leading, viewManagerViewModel.backButton ? 0 : UIScreen.main.bounds.width / 6)
                .multilineTextAlignment(.center)
            
            HStack {
                Button {
                    viewManagerViewModel.splitsForm.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Text("Splits")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                }
                .frame(width: 75, height: 26)
                .offset(x:10)
                
                // Add button, toggle the add form variable which will display a popup on respective view
                Button {
                    viewManagerViewModel.addForm.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Text("+")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 39, height: 26)
                .padding()
            }
        }
    }
}

#Preview {
    WorkoutHeaderView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
