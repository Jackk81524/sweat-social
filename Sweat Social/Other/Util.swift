//
//  Util.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-04-10.
//

import Foundation

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from:date)
}

func dateToStringHeader(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    
    return dateFormatter.string(from:date)
}

