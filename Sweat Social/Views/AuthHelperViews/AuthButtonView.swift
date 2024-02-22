//
//  EntryButtonView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import SwiftUI

// Abstracts button UI to approve auth, takes label and action as input.
//Saves code repetition across login and registration

struct AuthButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundColor(.black)
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size:16))
                    .fontWeight(.bold)
            }
            .frame(width: 141, height: 45)
            .padding()
        }
    }
}

#Preview {
    AuthButtonView(title: "Login") {
        // Action
    }
}
