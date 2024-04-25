//
//  GoalView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 2/15/24.
//

import SwiftUI

struct GoalsView: View {
    @State var goals: [Goal] = [
        Goal(name: "Do 300 Nm of work", numComplete: 290, numTotal: 300),
        Goal(name: "Do 2 hours of cardio", numComplete: 0, numTotal: 2),
        Goal(name: "Go to the gym 4 times this week", numComplete: 2, numTotal: 4),
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                
                Text("Weekly Goals!")
                    .font(.title)
                    .padding()
                
                GoalBlock(goal: goals[0])
                GoalBlock(goal: goals[1])
                GoalBlock(goal: goals[2])
                
                HStack {
                    Button(action: {
                        goals[0].numComplete -= 10
                    }) {
                        Text("Decrement 1")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goals[0].numComplete += 1
                    }) {
                        Text("Increment 1")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                HStack {
                    Button(action: {
                        goals[1].numComplete -= 1
                    }) {
                        Text("Decrement 2")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goals[1].numComplete += 1
                    }) {
                        Text("Increment 2")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                HStack {
                    Button(action: {
                        goals[2].numComplete -= 1
                    }) {
                        Text("Decrement 3")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goals[2].numComplete += 1
                    }) {
                        Text("Increment 3")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        requestNotifications()
                        scheduleLocalNotification()
                    }) {
                        Text("Notification")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                
                
                /*
                 FooterView()
                 .frame(maxWidth: .infinity)
                 .frame(minHeight: 75)
                 .background(Color.black)
                 .foregroundColor(.white)
                 */
                
            }
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Goal {
    var name: String
    var numComplete: Int
    var numTotal: Int
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
    var goal: Goal
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.gray)
                .cornerRadius(10)
            
            // Top Leading
            Text(self.goal.name)
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
                    Text(String(self.goal.numComplete) + "/" + String(self.goal.numTotal))
                        .padding(.bottom, 8)
                        .padding(.trailing, 8)
                }
            }
            
            // Center
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressBar(value: Float(self.goal.numComplete) / Float(self.goal.numTotal))
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
    GoalsView()
}
