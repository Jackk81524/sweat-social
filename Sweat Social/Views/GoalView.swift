//
//  GoalView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 2/15/24.
//

import SwiftUI

struct GoalView: View {
    var body: some View {
        VStack {
            HeaderView()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 100)
                .background(Color.black)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("Weekly Goals")
                .font(.title)
            
            Spacer()
            
            FooterView()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 75)
                .background(Color.black)
                .foregroundColor(.white)
            
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct HeaderView: View {
    var body: some View {
        Text("Sweat Social")
            .font(.largeTitle)
            .padding(.top, 50)
    }
}

struct FooterView: View {
    var body: some View {
        Text("NavBar")
            .font(.title)
    }
}

#Preview {
    GoalView()
}
