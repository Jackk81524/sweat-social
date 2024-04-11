//
//  DeleteConfirmationView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-03-26.
//

import SwiftUI

// Delete confirmations screen, used across all three views
struct DeleteConfirmationView: View {
    let toDelete: String
    let toDeleteType: String // Used to edit display message
    @Binding var update: Bool
    let delete: () -> Void
    
    @State var message : String = ""
    
    var body: some View {
        ZStack {
            FormTemplateView(height: 270)
            
            VStack {

                Text(message)
                    .font(.system(size:22))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .frame(width:320)
                    .offset(y:-30)
                
                // Confirmation button, calles delete function passed in from viewModel
                Button {
                    delete()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .foregroundColor(.black)
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.system(size:16))
                            .fontWeight(.bold)
                    }
                    .frame(width: 141, height: 45)
                }
                
                // Cancel button, toggles update variable which dismisses the popup
                Button {
                    update.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 32)
                            .foregroundColor(.black)
                        Text("Cancel")
                            .foregroundColor(.white)
                            .font(.system(size:16))
                            .fontWeight(.bold)
                    }
                    .frame(width: 141, height: 45)
                }
            }
        }
        .onAppear {
            message = (toDeleteType == "Set") ? "Are you sure you want to delete Set \(toDelete)?" : "Are you sure you want to delete the \(toDeleteType), \(toDelete)?" // Sets appropriate title
        }
        
    }
}

#Preview {
    DeleteConfirmationView(toDelete: "Arms", toDeleteType: "Workout", update: .constant(true)) {
    // Delete
    }
}
