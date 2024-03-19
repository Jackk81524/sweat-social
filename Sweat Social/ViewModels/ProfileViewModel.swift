//
//  ProfileViewModel.swift
//  Sweat Social
//
//  Created by Luke Chigges on 3/19/24.
//

import SwiftUI
import PhotosUI

struct PhotoSelector: View {
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var photo: UIImage? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedPhoto, matching: .images) {
            Text("Select a Photo")
        }
    }
}
