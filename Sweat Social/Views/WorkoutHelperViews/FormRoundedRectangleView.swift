//
//  FormRoundedRectangleView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-04.
//

import SwiftUI

struct FormRoundedRectangleView: View {
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: 0xF4F4F4))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.black, lineWidth: 2)
            )
            .frame(width:300,height:height)
    }
}

#Preview {
    FormRoundedRectangleView(height: 45)
}
