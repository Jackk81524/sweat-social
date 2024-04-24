//
//  RegisterTests.swift
//  Sweat SocialTests
//
//  Created by Jack.Knox on 2024-02-29.
//

import XCTest
@testable import Sweat_Social

final class RegisterTests: XCTestCase {
    
    func test_RegisterViewModel_email_shouldBeEmptyOnInitialization() {
        let viewModel = RegisterViewModel()
        
        XCTAssertEqual(viewModel.email, "")
        
    }
    
    func test_RegisterViewModel_password_shouldBeEmptyOnInitialization() {
        let viewModel = RegisterViewModel()
        
        XCTAssertEqual(viewModel.password, "")
        
    }
    
    func test_RegisterViewModel_errorMessage_shouldBeEmptyOnIntiInitialization() {
        let viewModel = RegisterViewModel()
        
        XCTAssertEqual(viewModel.errorMessage, "")
        
    }
    
    func test_RegisterViewModel_name_shouldBeEmptyOnIntiInitialization() {
        let viewModel = RegisterViewModel()
        
        XCTAssertEqual(viewModel.name, "")
        
    }
    
    func test_RegisterViewModel_confirmPassword_shouldBeEmptyOnIntiInitialization() {
        let viewModel = RegisterViewModel()
        
        XCTAssertEqual(viewModel.confirmPassword, "")
        
    }
    
    func test_RegisterViewModel_email_enteredCorrectly() {
        // Given
        let email: String = "test@mail.com"
        
        //When
        let viewModel = RegisterViewModel()
        viewModel.email = email
        
        //Then
        XCTAssertEqual(viewModel.email, email)
        
    }
    
    func test_RegisterViewModel_password_enteredCorrectly() {
        // Given
        let password: String = generateRandomString(length: Int.random(in: 6...14))
        
        //When
        let viewModel = RegisterViewModel()
        viewModel.password = password
        
        //Then
        XCTAssertEqual(viewModel.password, password)
        
    }
    
    func test_RegisterViewModel_confirmPassword_enteredCorrectly() {
        // Given
        let confirmPassword: String = generateRandomString(length: Int.random(in: 6...14))
        
        //When
        let viewModel = RegisterViewModel()
        viewModel.confirmPassword = confirmPassword
        
        //Then
        XCTAssertEqual(viewModel.confirmPassword, confirmPassword)
        
    }
    
    func test_RegisterViewModel_name_enteredCorrectly() {
        // Given
        let name: String = generateRandomString(length: Int.random(in: 6...14))
        
        //When
        let viewModel = RegisterViewModel()
        viewModel.name = name
        
        //Then
        XCTAssertEqual(viewModel.name, name)
        
    }
    
    func test_RegisterViewModel_errorMessage_enteredCorrectly() {
        let errorMessage: String = "Hello Testing World!"
        
        let viewModel = RegisterViewModel()
        viewModel.errorMessage = errorMessage
        
        XCTAssertEqual(viewModel.errorMessage, errorMessage)
    }
    
    func test_RegisterViewModel_Register_blankFields() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = String(repeating: " ",count: numberOfSpaces)
        let password = String(repeating: " ",count: numberOfSpaces)
        let confirmPassword = String(repeating: " ",count: numberOfSpaces)
        let name = String(repeating: " ",count: numberOfSpaces)
        let viewModel = RegisterViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.confirmPassword = confirmPassword
        viewModel.name = name
        
        viewModel.register()
        
        XCTAssertEqual(viewModel.errorMessage, "Please fill in all fields.")
    }
    
    func test_RegisterViewModel_Register_invalidEmail() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = generateRandomString(length: Int.random(in: 6...16))
        let password = generateRandomString(length: Int.random(in: 6...16))
        let confirmPassword = password
        let name = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = RegisterViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid email.")
        
        
    }
    
    func test_RegisterViewModel_Register_passwordOverSixChars() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in: 2...5))
        let confirmPassword = generateRandomString(length: Int.random(in: 2...5))
        let name = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = RegisterViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        XCTAssertEqual(viewModel.errorMessage, "Password must be at least 6 characters.")
    }
    
    func test_RegisterViewModel_Register_passWordsNotEqual() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = "test@email.com"
        let password = "password"
        let confirmPassword = "password2"
        let name = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = RegisterViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match.")
        
        
    }
    
    func test_RegisterViewModel_Register_succesfulRegister_succesfulFirestore() {
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in:6...10))
        let confirmPassword = password
        let name = generateRandomString(length: Int.random(in: 7...12))
        
        let viewModel = RegisterViewModel(auth: MockFirebaseAuthServiceSuccess(), firestore: MockFirebaseFirestoreServiceSuccess())
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        XCTAssertEqual(viewModel.userId, password) // Password is used to mock userId, look at helper
        XCTAssertEqual(viewModel.password, password)
        XCTAssertEqual(viewModel.email, email)
        XCTAssertEqual(viewModel.name, name)
        XCTAssertEqual(viewModel.errorMessage,"")
    }
    
    func test_RegisterViewModel_Register_failedRegister() {
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in:6...10))
        let confirmPassword = password
        let name = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = RegisterViewModel(auth: MockFirebaseAuthServiceFailed(), firestore: MockFirebaseFirestoreServiceSuccess()) // Firestore should be irrelevant, if code works correctly then it shouldnt be used
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        //XCTAssertEqual(viewModel.password, password)
        XCTAssertEqual(viewModel.errorMessage,"Failure creating user.")
    }
    
    func test_RegisterViewModel_Register_succesfulRegister_failedFirestore() {
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in:6...10))
        let confirmPassword = password
        let name = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = RegisterViewModel(auth: MockFirebaseAuthServiceSuccess(), firestore: MockFirebaseFirestoreServiceFailed())
        viewModel.email = email
        viewModel.password = password
        viewModel.name = name
        viewModel.confirmPassword = confirmPassword
        
        viewModel.register()
        
        //XCTAssertEqual(viewModel.password, password)
        XCTAssertEqual(viewModel.errorMessage,"Failure connecting to Firestore.")
    }
}
