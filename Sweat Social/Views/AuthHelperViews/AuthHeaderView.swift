//
//  EntryHeaderView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-11.
//

import SwiftUI

// Creates and abstracts the rounded header to be used on login and registration pages
// Can be used easily if desired in future
struct AuthHeaderView: View {
    var body: some View {
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
        .offset(y: -190)
        .padding()
    }
}

#Preview {
    AuthHeaderView()
}
