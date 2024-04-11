//
//  FormTemplateView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-03.
//

import SwiftUI

struct FormTemplateView: View {
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 16,style:.continuous)
                .strokeBorder(Color.black,lineWidth:2)
                .background(Color.white)
                .foregroundStyle(.white)
                .frame(width: 350, height: height)
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .frame(width: 350, height: 100)
                    .foregroundStyle(.black)
                Rectangle()
                    .frame(width:350, height: 20)
                    .foregroundStyle(.black)
                    .offset(y:40)
            }
            
        }
    }
}

#Preview {
    FormTemplateView(height: 270)
}
