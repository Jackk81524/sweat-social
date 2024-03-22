//
//  GoalView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 2/15/24.
//

import SwiftUI

struct GoalsView: View {
    @StateObject var goalsManager = GoalsManager(goals: [
        Goal(name: "Do 300 Nm of work", numComplete: 299, numTotal: 300),
        Goal(name: "Do 2 hours of cardio", numComplete: 0, numTotal: 2),
        Goal(name: "Go to the gym 4 times this week", numComplete: 2, numTotal: 4),
    ])
    
    var body: some View {
        VStack {
            HeaderView()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 100)
                .background(Color.black)
                .foregroundColor(.white)
            
            ScrollView {
                Text("Weekly Goals!")
                    .font(.title)
                    .padding()
                
                ForEach(0..<goalsManager.goals.count, id: \.self) { index in
                    GoalBlock(goalsManager: goalsManager, goalIndex: index)
                }

                HStack {
                    Button(action: {
                        goalsManager.decrementGoal(index: 0)
                    }) {
                        Text("Decrement 1")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goalsManager.incrementGoal(index: 0)
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
                        goalsManager.decrementGoal(index: 1)
                    }) {
                        Text("Decrement 2")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goalsManager.incrementGoal(index: 1)
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
                        goalsManager.decrementGoal(index: 2)
                    }) {
                        Text("Decrement 3")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        goalsManager.incrementGoal(index: 2)
                    }) {
                        Text("Increment 3")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Goals Scroll")
            
            
            
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

class GoalsManager: ObservableObject {
    @Published var goals: [Goal]
    
    init(goals: [Goal]) {
        self.goals = goals
    }
    
    var allComplete: Bool {
        goals.allSatisfy { $0.numComplete >= $0.numTotal }
    }
    
    func incrementGoal(index: Int) {
        if goals.indices.contains(index) {
            goals[index].numComplete += 1
        }
    }
    
    func decrementGoal(index: Int) {
        if goals.indices.contains(index) {
            goals[index].numComplete -= 1
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
    @ObservedObject var goalsManager: GoalsManager
    var goalIndex: Int
    let goldColor = Color(red: 0.796, green: 0.746, blue: 0.327)
    let silverColor = Color(red: 0.592, green: 0.592, blue: 0.592)
    let rainbowGradient = LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow]), startPoint: .leading, endPoint: .trailing)
    let greyGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color(red: 0.7, green: 0.7, blue: 0.7)]), startPoint: .top, endPoint: .bottom)
    let goldGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.83, green: 0.69, blue: 0.22), // Dark Gold
            Color(red: 1.0, green: 0.84, blue: 0) // Gold
        ]),
        startPoint: .top,
        endPoint: .bottom)
    
    var body: some View {
        let numComplete: Float = Float(goalsManager.goals[goalIndex].numComplete)
        let numTotal: Float = Float(goalsManager.goals[goalIndex].numTotal)
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(goalsManager.allComplete ? rainbowGradient :
                        (numComplete / numTotal >= 1.0) ?
                      goldGradient : greyGradient)
                .cornerRadius(10)
            
            // Top Leading
            Text(goalsManager.goals[self.goalIndex].name)
                .padding(.top, 8)
                .padding(.leading, 8)
            
            // Top Trailing
            /*VStack {
                HStack {
                    Spacer()
                    Text("Top Trailing")
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                }
                Spacer()
            }*/
            
            // Bottom Leading
            /* VStack {
                Spacer()
                HStack {
                    Text("Bottom Leading")
                        .padding(.bottom, 8)
                        .padding(.leading, 8)
                    Spacer()
                }
            }*/
            
            // Bottom Trailing
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(String(numComplete) + "/" + String(numTotal))
                        .padding(.bottom, 8)
                        .padding(.trailing, 8)
                }
            }
            
            // Center
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressBar(value: numComplete / numTotal)
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
