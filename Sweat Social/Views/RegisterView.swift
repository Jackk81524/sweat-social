//
//  RegisterView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                EntryHeaderView()
                
                VStack {
                    Text("Register with us now")
                        .font(.system(size:26))
                        .padding(.bottom, 20)
                    
                    EntryTextFieldView(display: "Full Name",
                                       input: $viewModel.name)
                    EntryTextFieldView(display: "Email",
                                       input: $viewModel.email)
                    EntryPasswordView(display: "Password",
                                      input: $viewModel.password)
                    EntryPasswordView(display: "Confirm Password",
                                      input: $viewModel.confirm_password)
                    
                    EntryButtonView(title: "Sign up")
                    {
                        viewModel.register()
                    }
                }
                .offset(y:-200)
                
                VStack {
                    Text("Already have an account?")
                    NavigationLink("Log in", destination: LoginView())
                }
                
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
