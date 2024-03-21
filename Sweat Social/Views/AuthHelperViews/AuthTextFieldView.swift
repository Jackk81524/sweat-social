//
//  EntryTextFieldView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

// Abstracts the rounded text input seen on auth views.
// Saves code repetition
struct AuthTextFieldView: View {
    let display: String
    @Binding var input: String

    var body: some View {
        TextField(display, text: $input)
            .padding()
            .autocapitalization(.none)
            .autocorrectionDisabled()
            .frame(width:306,height: 45)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.black,lineWidth:2)
            )
    }
}

#Preview {
    AuthTextFieldView(display: "Email", input: .constant("Email"))
}
