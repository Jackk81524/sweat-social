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
        NavigationStack {
            ZStack {
                // add header
                AuthHeaderView()
                    .offset(y:-125)
                
                VStack {
                    Text("Already have an account?")
                        .font(.system(size:26))
                        .padding(.bottom, 20)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            
                    }
                    
                    
                    AuthTextFieldView(display: "Email Address", input: $viewModel.email)
                    AuthPasswordView(display: "Password", input: $viewModel.password)
                    
                    AuthButtonView(title: "Login") {
                        viewModel.login()
                    }
                    
                }
                .offset(y:-30)
                
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Create one", destination: RegisterView())
                }
                .offset(y:320)
            }
        }
    }
    
}
    
#Preview {
    LoginView()
}
