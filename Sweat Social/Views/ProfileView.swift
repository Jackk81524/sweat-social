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
        ScrollView {
            VStack {
                Spacer().frame(height: 75)
                
                Text("John Smith")
                    .font(.system(size:26))
                    .padding(.bottom, 20)
                
                displayImageFromURL(urlString: viewModel.profilePictureURL)
                
                PhotoPicker(onImageSelected: viewModel.storeProfilePictureImageInDatabase)
                
                Spacer().frame(height: 75)
                
                VStack {
                    Text("Bio")
                        .font(.system(size:26))
                        .padding(.bottom, 20)
                        .padding(.top, 25)
                    
                    Text("Growing up, I was always intrigued by the power of a well-balanced life, where fitness and mental well-being go hand in hand. This fascination led me to delve deeper into the world of fitness, exploring various disciplines from high-intensity interval training (HIIT) to yoga and everything in between. The more I learned, the more I realized how transformative a committed fitness regimen could be.")
                        .font(.system(size:20))
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
            }
        }
    }
}

#Preview {
    ProfileView()
}
