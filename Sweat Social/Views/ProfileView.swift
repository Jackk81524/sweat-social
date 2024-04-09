//
//  ProfileView.swift
//  Sweat Social
//
//  Created by Arryan Bhatnagar on 3/26/24.
//

import SwiftUI

struct ProfileView: View {
    
    let name: String
    @StateObject var viewModel: ProfileViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel())
        self.name = ""
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                if let user = viewModel.user {
                    VStack {
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
                        
                        NavigationLink(destination: AnotherView()) {
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
                        
                        NavigationLink(destination: AnotherView()) {
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

struct AnotherView: View {
    var body: some View {
        Text("Another View")
            .navigationTitle("Another View")
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
    let user: User
    @ObservedObject var viewModel: UserSearchViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)

            Text(user.email)
                .font(.subheadline)
            
            Button(action: {
                if viewModel.followingUserIds.contains(user.id) {
                    // You might want to implement an "unfollow" functionality
                } else {
                    viewModel.followUser(user.id)
                }
            }) {
                Text(viewModel.followingUserIds.contains(user.id) ? "Following" : "Follow")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(viewModel.followingUserIds.contains(user.id) ? Color.green : Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchFollowing()
        }
    }
}

