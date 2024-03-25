//
//  WorkoutHeaderView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-05.
//

import SwiftUI

struct WorkoutHeaderView: View {
    @ObservedObject var viewManagerViewModel: WorkoutViewManagerViewModel
    
    @Environment(\.presentationMode) private var
        presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack{
            if(viewManagerViewModel.backButton){
                Button {
                    viewManagerViewModel.dismiss.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                        Text("<-")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    .frame(width: 39, height: 26)
                    .padding()
                    
                }
                
            }
                
            
            Text(viewManagerViewModel.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size:24))
                .padding(.leading, viewManagerViewModel.backButton ? 0 : UIScreen.main.bounds.width / 6)
            
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
                .frame(width: 39, height: 26)
                .padding()
                
            }
        }
    }
}

#Preview {
    WorkoutHeaderView(viewManagerViewModel: WorkoutViewManagerViewModel())
}
