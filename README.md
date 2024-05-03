# sweat-social

## Description

Sweat social is a fitness logging app that aims to bring social elements to your workout. Users can log their workouts, view past workouts, earn badges, and share their achievements with friends.

Our app connects to Google FireStore to store user data and Firebase Authentication to manage user accounts.

Many features are attached to this firestore connection and requires a google-services.plist file to operate successfully.

Our mission is to create a social-driven fitness platform that enhances user motivation through community engagement. Key features include:

Authentication: Users securely sign in and access the app via Firebase authentication.
Workout Logging: Real-time logging of workouts with intuitive input mechanisms for exercises, sets, and tracking progress.
Social Activity: Users can connect with friends, follow their activities, and provide support and encouragement.
Gamification: Progress is incentivized through unlockable badges, rewarding users for their achievements.
Profile Customization: Users can personalize their profiles and connect with friends within the app.

Our application fosters a supportive environment for users to track their fitness journeys, connect with others, and stay motivated towards their goals!

## Directory Structure

The project is organized as follows:

```
├── .github                   # Holds our workflows and actions
├── Sweat Social.xcodeproj    # Files used by Xcode
├── Sweat Social              # The main source files for the app
│    ├── FirebaseAPI          # Modules for interacting with Firebase database
│    ├── Models               # Contains data structures
│    ├── ViewModels           # Contains backend logic and helper classes for views
│    └── Views                # Contains the views themselves
├── Sweat SocialTests         # Automated tests
├── Sweat SocialUITests       # UI tests
├── Sweat-Social.plist        # Important project configuration file
└── README.md
```

## Documentation

[User Guide](https://docs.google.com/document/d/15LfSaUg9MpbbzTAgEFJU7VYW3N3QlGq33Tgy4MyFz3A/edit?usp=sharing)

## Installation

Sweat Social is an iOS app that is not currently on the App Store. It can be downloaded through Test Flight to a limited audience.
