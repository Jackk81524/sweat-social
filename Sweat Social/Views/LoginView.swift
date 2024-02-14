//
//  LoginView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

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
                    
                    
                    TextField("Email Address", text: $viewModel.email)
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .autocorrectionDisabled()
                        .frame(width:306,height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black,lineWidth:2)
                        )
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .frame(width:306,height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black,lineWidth:2)
                        )
                    
                    Button {
                        viewModel.login()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 32)
                                .foregroundColor(.black)
                            Text("Login")
                                .foregroundColor(.white)
                                .font(.system(size:16))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .frame(width: 141, height: 45)
                        .padding()
                    }
                    
                }
                .offset(y:-200)
                
                /*GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal))
                    {
                    
                }*/
                
            }
        }
    }
    
}
    
#Preview {
    LoginView()
}
