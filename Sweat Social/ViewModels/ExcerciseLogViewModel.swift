//
//  ExcerciseLogViewModel.swift
//  Sweat Social
//
//  Created by Jack.Knox on 2024-02-25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ExcerciseLogViewModel: ObservableObject {
    @Published var excercises: [Excercises]? = []
    @Published var addExcerciseForm = false

    
    init() {
        
    }
    
    func addExcercise(excerciseToAdd: String) {
        let newExcercise = Excercises(name: excerciseToAdd, sets: [])
        if var excercises = excercises {
            excercises.append(newExcercise)
            self.excercises = excercises
        }
    }
}
