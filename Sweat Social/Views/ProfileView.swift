//
//  ProfileView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 3/19/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack {
            text("John Smith")
            
            displayImageFromURL(urlString: viewModel.profilePictureURL)
            
            PhotoPicker(onImageSelected: viewModel.storeProfilePictureImageInDatabase)
        }
    }
}

#Preview {
    ProfileView()
}
