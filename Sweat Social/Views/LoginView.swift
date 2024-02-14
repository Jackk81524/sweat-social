//
//  LoginView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                EntryHeaderView()
                
                VStack {
                    Text("Already have an account?")
                        .font(.system(size:26))
                        .padding(.bottom, 20)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            
                    }
                    
                    
                    EntryTextFieldView(display: "Email Address", input: $viewModel.email)
                    EntryPasswordView(display: "Password", input: $viewModel.password)
                    
                    EntryButtonView(title: "Login") {
                        viewModel.login()
                    }
                    
                    
                    
                }
                .offset(y:-200)
                
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Create one", destination: RegisterView())
                }
            }
        }
    }
    
}
    
#Preview {
    LoginView()
}
