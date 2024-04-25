//
//  ProfileViewModel.swift
//  Sweat Social
//
//  Created by Luke Chigges on 3/19/24.
//

import SwiftUI
import PhotosUI
import Foundation
import FirebaseStorage
import Firebase

class ProfilePictureViewModel: ObservableObject {
    @Published var userID = ""
    @Published var profilePictureURL: String = ""
    //@Published var addWorkoutForm = false
    @Published var currentUser: User?
    //@Published var workoutGroups: [WorkoutGroup]?
    private var db = Firestore.firestore()
    
    init() {
        if let user = Auth.auth().currentUser {
            userID = user.uid
            fetchProfilePictureURL()
        } else {
            print("Could not initialize profile View Model. Auth failed.")
        }
    }
    
    func fetchProfilePictureURL() {
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    self.currentUser = try document.data(as: User.self)
                    
                    if let profilePictureURL = self.currentUser?.profilePictureURL {
                        self.profilePictureURL = profilePictureURL
                    }
                } catch {
                    print(error)
                }
            } else {
                print("Document does not exist")
                return
            }
        }
    }
    
    func uploadProfilePictureUrlInDatabaseAndFetch(imageURL: String) {
        db.collection("users").document(userID).updateData(["profilePictureURL": imageURL]) { error in
            if let error = error {
                print("Failed to update user profile in Firebase Database: \(error.localizedDescription)")
            } else {
                print("User profile updated successfully with new image URL.")
            }
        }
        fetchProfilePictureURL()
    }
    
    func storeProfilePictureImageInDatabase(imageData: Data) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageURL = "profilePictures/\(self.userID).jpg"
        let profilePicRef = storageRef.child(imageURL)

        
        profilePicRef.putData(imageData, metadata: nil) { metadata, error in
            guard error == nil else {
                print("Failed to upload image to Firebase Storage: \(error!.localizedDescription)")
                return
            }
            
            // After the image is uploaded, fetch the download URL
            profilePicRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Failed to get download URL: \(error!.localizedDescription)")
                    return
                }
                
                // Update the user's profile in Firebase Database with this URL
                self.uploadProfilePictureUrlInDatabaseAndFetch(imageURL: downloadURL.absoluteString)
            }
        }
    }
}

struct displayImageFromURL: View {
    var urlString: String
    let imageSize: CGFloat = 150
    var body: some View {
        
        print("Loading URL from string:", urlString)
        
        guard let url = URL(string: urlString) else {
            return AnyView(Text("Invalid URL"))
        }
        
        print("Loading URL:", url.absoluteString)

        return AnyView(
            AsyncImage(url: url) { phase in
                switch phase {
                    case .empty:
                        ProgressView() // Displayed while the image is loading
                    case .success(let image):
                        image.resizable() // Display the loaded image
                             .aspectRatio(contentMode: .fill)
                    case .failure:
                        // Displayed if there is an error loading the image
                        Text("Error loading image.")
                            .frame(width: imageSize, height: imageSize)
                            .background(Color.gray)
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView() // Fallback for future cases
                }
            }
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
        )
    }
}

struct PhotoPicker: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    var onImageSelected: (Data) -> Void
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            Text("Select a Photo")
        }
        .onChange(of: selectedItem) { newItem in
            guard let newItem = newItem else { return }
            newItem.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        DispatchQueue.main.async {
                            self.onImageSelected(data)
                        }
                    }
                case .failure(let error):
                    // Handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
}
