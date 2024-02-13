//
//  ContentView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            Text("Welcome to your account")
        } else {
            LoginView()
        }
        
    }
}

#Preview {
    ContentView()
}
