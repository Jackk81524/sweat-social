//
//  AuthSmartReqE2ETest.swift
//  Sweat SocialTests
//
//  Created by Jack.Knox on 2024-04-18.
//

import XCTest
import Firebase
import FirebaseFirestore

@testable import Sweat_Social

final class AuthSmartReqE2ETest: XCTestCase {
    var firestore: FirestoreProtocol = FirebaseFirestoreService()
    var auth: AuthProtocol = FirebaseAuthService()
    
    let mockWorkout = WorkoutExercise(id: "Test", dateAdded: Date().timeIntervalSince1970)
    
    override func setUp() {
        do {
             try Auth.auth().signOut()
        } catch _ as NSError {
             //Catch
        }
    }
    
    func test_FirebaseUserAccess_E2E_insertWorkout_failure() {
        let userId = auth.currentUser
        print(userId)
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.insertWorkout(userId: userId, newWorkoutCategory: mockWorkout, newExercise: nil) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_insertNewUser_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.insertNewUser(userId: userId, name: "Mock Name", email: "test@mail.com") { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_insertSet_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.insertSet(userId: userId, workout: "Biceps", exercise: "Curl", reps: 5, weight: 5){ result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_deleteWorkout_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.deleteWorkout(userId: userId, workoutToDelete: mockWorkout, exerciseToDelete: nil) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_deleteSet_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.deleteSet(userId: userId, workout: "Biceps", exercise: "Curl", index: 0) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_fetchWorkouts_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.fetchWorkouts(userId: userId, workout: nil, date: nil) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_fetchSets_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.fetchSets(userId: userId, workout: "Biceps", exercise: "Curl", date: nil) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_deleteSplit_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.deleteSplit(userId: userId, splitToDelete: "Arms") { error in
            if let error = error {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_addSplit_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.addSplit(userId: userId, split: Split(id: "arms", dateAdded: Date().timeIntervalSince1970, workouts: [])) { error
            in
            if let error = error {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_fetchSplits_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.fetchSplits(userId: userId) { result in
            if case .failure(_) = result {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
    
    func test_FirebaseUserAccess_E2E_logSavedWorkout_failure() {
        let userId = auth.currentUser
        let expectation = XCTestExpectation(description: "Firebase connection should fail")
        
        // Simulate user authentication
        // For example, sign in with a test user
        firestore.logSavedWorkout(userId: userId, workoutsToLog: [], logMessage: nil, splitName: "arms") { error
            in
            if let error = error {
                expectation.fulfill()
            } else {
                XCTFail("Unathenticated user was able to access Firestore.")
            }
        }
        
        wait(for: [expectation], timeout: 5.0) // Adjust timeout as needed
    }
}
