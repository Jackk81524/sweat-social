//
//  File.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-07.
//

import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    init() {}
    
    func login() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        print("called")
    }
}


