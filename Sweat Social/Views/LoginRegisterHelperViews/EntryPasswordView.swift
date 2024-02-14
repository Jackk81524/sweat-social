//
//  EntryPasswordView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

struct EntryPasswordView: View {
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
    EntryPasswordView(display: "Password", input: .constant("Password"))
}
