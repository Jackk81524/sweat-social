//
//  Sweat_SocialApp.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 1/31/24.
//

import SwiftUI
import FirebaseCore

@main
struct Sweat_SocialApp: App {
    
    init() {
        FirebaseApp.configure()
        
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
