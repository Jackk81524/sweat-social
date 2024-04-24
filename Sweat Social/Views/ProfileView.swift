//
//  ProfileView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 3/26/24.
//

import SwiftUI

struct SelfProfileView: View {
    
    let name: String
    @StateObject var followingViewModel = FollowingViewModel()
    @StateObject var followersViewModel = FollowersViewModel()
    @StateObject var viewModel: ProfileViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel())
        self._followingViewModel = StateObject(wrappedValue: FollowingViewModel())
        self._followersViewModel = StateObject(wrappedValue: FollowersViewModel())
        self.name = ""
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let user = viewModel.user {
                    VStack {
                        
                        ProfilePictureView()
                        
                        HStack {
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        HStack {
                            Text(user.email)
                                .font(.system(.title3, design: .monospaced))
                            Spacer()
                        }
                        .padding([.bottom, .horizontal])
                        
                        NavigationLink(destination: FollowersView(viewModel: followersViewModel)) {
                            HStack {
                                Text("Followers")
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .onAppear {
                            followersViewModel.fetchFollowers(userId: viewModel.userId)
                        }
                        
                        NavigationLink(destination: FollowingView(viewModel: followingViewModel)) {
                            HStack {
                                Text("Following")
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundStyle(.black)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        .onAppear {
                            followingViewModel.fetchFollowing(userId: viewModel.userId)
                        }
                        
                        NavigationLink(destination: UserSearchView()) {
                            Text("Search Users")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                } else {
                    ProgressView()
                }
            }
        }
    }
}


struct FollowersView: View {
    @ObservedObject var viewModel: FollowersViewModel

    var body: some View {
        List(viewModel.followers) { user in
            NavigationLink(destination: UserProfileView(user: user, viewModel: UserSearchViewModel())) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .fontWeight(.bold)
                    Text(user.email)
                        .font(.caption)
                }
                Spacer()
            }
        }
        .navigationTitle("Followers")
    }
}

struct FollowingView: View {
    @ObservedObject var viewModel: FollowingViewModel

    var body: some View {
        List(viewModel.following) { user in
            NavigationLink(destination: UserProfileView(user: user, viewModel: UserSearchViewModel())) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .fontWeight(.bold)
                    Text(user.email)
                        .font(.caption)
                }
                Spacer()
            }
        }
        .navigationTitle("Following")
    }
}


struct UserSearchView: View {
    @ObservedObject var viewModel = UserSearchViewModel()

    var body: some View {
        VStack {
            TextField("Search users...", text: $viewModel.searchQuery)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
                .onSubmit {
                    viewModel.performSearch(query: viewModel.searchQuery)
                }
            
            List(viewModel.searchResults) { user in
                NavigationLink(destination: UserProfileView(user: user, viewModel: viewModel)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .fontWeight(.bold)
                            Text(user.email)
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Search Users")
    }
}



struct UserProfileView: View {
    var user: User
    @ObservedObject var viewModel: UserSearchViewModel
    @StateObject var viewManagerViewModel : WorkoutViewManagerViewModel
    
    init(user: User, viewModel: UserSearchViewModel) {
        self.user = user
        self.viewModel = viewModel
        self._viewManagerViewModel = StateObject(wrappedValue: WorkoutViewManagerViewModel(userId: user.id))
    }
    

    var body: some View {
        VStack() {
            VStack(spacing: 8) {
                HStack {
                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack {
                    Text(user.email)
                        .font(.subheadline)
                    Spacer()
                }
                
                
                Button(action: {
                    if viewModel.followingUserIds.contains(user.id) {
                        // You might want to implement an "unfollow" functionality
                    } else {
                        viewModel.followUser(user.id)
                    }
                }) {
                    Text(viewModel.followingUserIds.contains(user.id) ? "Following" : "Add Friend")
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.followingUserIds.contains(user.id) ? Color.green : Color.blue)
                        .cornerRadius(10)
                }
            }
            
            
            if viewModel.followingUserIds.contains(user.id) {
                VStack {
                    //Main feature, sets the title, and add/back buttons. The viewManagerViewModel controls the title and other variation
                    WorkoutHeaderView(viewManagerViewModel: viewManagerViewModel)
                        .padding(.top,20)
                        .frame(height: 60)
                    
                    NavigationStack{
                        WorkoutLogView(viewManagerViewModel: viewManagerViewModel)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
                .onAppear {
                    viewManagerViewModel.allowEditing = false
                }
            }
        }
        .padding()
        
        .onAppear {
            viewModel.fetchFollowStatus()
        }
    }
}
