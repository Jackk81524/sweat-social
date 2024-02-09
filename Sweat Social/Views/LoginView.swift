//
//  LoginView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            ZStack {
                Ellipse()
                    .foregroundColor(.black)
                
                Text("Sweat Social")
                    .font(.custom("Futura-MediumItalic", size: 64))
                    .fontWidth(.condensed)
                    .foregroundStyle(.white)
                    .baselineOffset(-135)
                    .bold()
                
            }
            .frame(width: UIScreen.main.bounds.width * 2.3, height: 259)
            .offset(y: -315)
            
            VStack {
                Text("Already have an account?")
                    .font(.system(size:26))
                    .padding(.bottom, 20)
                
                
                TextField("Email Address", text: $email)
                    .padding()
                    .frame(width:306,height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.black,lineWidth:2)
                    )
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width:306,height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.black,lineWidth:2)
                    )
                
            }
            .offset(y:-275)
        }
    }
}
    
#Preview {
    LoginView()
}
