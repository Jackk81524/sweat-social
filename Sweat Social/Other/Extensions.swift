//
//  Extensions.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-14.
//

import Foundation

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
}
