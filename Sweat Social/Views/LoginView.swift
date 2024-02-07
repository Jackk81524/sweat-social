//
//  LoginView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import SwiftUI

struct LoginView: View {
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
        }
    }
}
    
#Preview {
    LoginView()
}
