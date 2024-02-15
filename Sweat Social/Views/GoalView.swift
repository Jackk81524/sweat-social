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
            
            GoalBlock()
            
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

struct GoalBlock: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.gray)
            
            // Top Leading
            Text("Top Leading")
                .padding(.top, 8)
                .padding(.leading, 8)
            
            // Top Trailing
            VStack {
                HStack {
                    Spacer()
                    Text("Top Trailing")
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                }
                Spacer()
            }
            
            // Bottom Leading
            VStack {
                Spacer()
                HStack {
                    Text("Bottom Leading")
                        .padding(.bottom, 8)
                        .padding(.leading, 8)
                    Spacer()
                }
            }
            
            // Bottom Trailing
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Bottom Trailing")
                        .padding(.bottom, 8)
                        .padding(.trailing, 8)
                }
            }
            
            // Center
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Center")
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: 370, height: 120) // The size for the Rectangle
    }
}


#Preview {
    GoalView()
}
