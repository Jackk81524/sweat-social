//
//  AnalyticsView.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-22.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    private init() { }
    
    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
        
}

