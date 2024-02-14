//
//  EntryTextFieldView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

struct EntryTextFieldView: View {
    let display: String
    @Binding var input: String

    var body: some View {
        TextField(display, text: $input)
            .padding()
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .autocorrectionDisabled()
            .frame(width:306,height: 45)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.black,lineWidth:2)
            )
    }
}

#Preview {
    EntryTextFieldView(display: "Email", input: .constant("Email"))
}
