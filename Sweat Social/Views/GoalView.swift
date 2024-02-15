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
            Text("Goal Name")
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
                    Text("13/20") // TODO: Use a variable for this
                        .padding(.bottom, 8)
                        .padding(.trailing, 8)
                }
            }
            
            // Center
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressBar(value: 13/20)
                        .frame(height: 20)
                        .padding(10)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: 370, height: 120) // The size for the Rectangle
    }
}

struct ProgressBar: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle() // Background of progress bar
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                Rectangle() // Filled portion of the bar
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.yellow)
                    .animation(.linear, value: value)
            }
            .cornerRadius(45.0)
        }
    }
}

#Preview {
    GoalView()
}
