//
//  EntryPasswordView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

// Abstracts rounded password input seen on auth inputs
// Needs to be different then AuthTextFieldView as this view hides characters inputted, as is typical during password input
struct AuthPasswordView: View {
    let display: String
    @Binding var input: String
    
    var body: some View {
        SecureField(display, text: $input)
            .padding()
            .frame(width:306,height: 45)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.black,lineWidth:2)
            )
    }
}

#Preview {
    AuthPasswordView(display: "Password", input: .constant("Password"))
}
