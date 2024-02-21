//
//  RegisterView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

struct RegisterView: View {
    // Below lines are needed to edit back button. Without, the Log in button would not go back to Login View, but create an entirely new login view on navigation stack.
    @Environment(\.presentationMode) private var
        presentationMode: Binding<PresentationMode>
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                AuthHeaderView()
                    .offset(y:-125)
                
                VStack {
                    Text("Register with us now")
                        .font(.system(size:26))
                        .padding(.bottom, 20)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            
                    }
                    AuthTextFieldView(display: "Full Name",
                                       input: $viewModel.name)
                    AuthTextFieldView(display: "Email",
                                       input: $viewModel.email)
                    AuthPasswordView(display: "Password",
                                      input: $viewModel.password)
                    AuthPasswordView(display: "Confirm Password",
                                      input: $viewModel.confirmPassword)
                    
                    AuthButtonView(title: "Sign up")
                    {
                        viewModel.register()
                    }
                }
                .offset(y:25)
                
                VStack {
                    Text("Already have an account?")
                    Button(action: {
                        presentationMode.wrappedValue
                            .dismiss()
                    }, label: {
                        Text("Log in")
                    })
                }
                .offset(y:320)
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
