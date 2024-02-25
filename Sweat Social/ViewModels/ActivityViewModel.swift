//
//  ActivityViewModel.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 2/25/24.
//

import Foundation
import FirebaseFirestore

class ActivityViewModel: ObservableObject {
    @Published var users = [User]()
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Empty")
                return
            }
            
            self.users = documents.map { (QueryDocumentSnapshot) -> User in
                let data = QueryDocumentSnapshot.data()
                
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let joined = data["joined"] as? TimeInterval ?? 0

                
                return User(id: id, name: name, email: email, joined: joined)
                
            }
            
        }
    }
}
