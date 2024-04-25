//
//  ProfileView.swift
//  Sweat Social
//
//  Created by Luke Chigges on 3/19/24.
//

import SwiftUI
import PhotosUI

struct ProfilePictureView: View {
    @StateObject var viewModel = ProfilePictureViewModel()
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 10)
                
                displayImageFromURL(urlString: viewModel.profilePictureURL)
                
                PhotoPicker(onImageSelected: viewModel.storeProfilePictureImageInDatabase)
                
                Spacer().frame(height: 10)
            }
        }
    }
}

#Preview {
    ProfilePictureView()
}

