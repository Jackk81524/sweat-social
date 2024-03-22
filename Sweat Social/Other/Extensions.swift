//
//  Extensions.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import Foundation
import SwiftUI

// Helper function to automatically convert model to JSON format
extension Encodable {
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
        
    }
    
    static func fromDictionary<T: Decodable>(_ dictionary: [String: Any]) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)
    }
}

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}
