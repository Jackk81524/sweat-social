//
//  LoginTests.swift
//  Sweat SocialTests
//
//  Created by Jack.Knox on 2024-02-28.
//

import XCTest

@testable import Sweat_Social

final class LoginTests: XCTestCase {
    
    func test_LoginViewModel_email_shouldBeEmptyOnInitialization() {
        let viewModel = LoginViewModel()
        
        XCTAssertEqual(viewModel.email, "")
        
    }
    
    func test_LoginViewModel_password_shouldBeEmptyOnInitialization() {
        let viewModel = LoginViewModel()
        
        XCTAssertEqual(viewModel.password, "")
        
    }
    
    func test_LoginViewModel_errorMessage_shouldBeEmptyOnIntiInitialization() {
        let viewModel = LoginViewModel()
        
        XCTAssertEqual(viewModel.errorMessage, "")
        
    }
    func test_LoginViewModel_email_enteredCorrectly() {
        // Given
        let email: String = "test@mail.com"
        
        //When
        let viewModel = LoginViewModel()
        viewModel.email = email
        
        //Then
        XCTAssertEqual(viewModel.email, email)
        
    }
    
    func test_LoginViewModel_password_enteredCorrectly() {
        // Given
        let password: String = generateRandomString(length: Int.random(in: 6...14))
        
        //When
        let viewModel = LoginViewModel()
        viewModel.password = password
        
        //Then
        XCTAssertEqual(viewModel.password, password)
        
    }
    
    func test_LoginViewModel_errorMessage_enteredCorrectly() {
        let errorMessage: String = "Hello Testing World!"
        
        let viewModel = LoginViewModel()
        viewModel.errorMessage = errorMessage
        
        XCTAssertEqual(viewModel.errorMessage, errorMessage)
    }
    
    func test_LoginViewModel_login_blankFields() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = String(repeating: " ",count: numberOfSpaces)
        let password = String(repeating: " ",count: numberOfSpaces)
        
        let viewModel = LoginViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage, "Please fill in all fields.")
    }
    
    func test_LoginViewModel_login_validEmail() {
        let numberOfSpaces = Int.random(in:1...10)
        let email = generateRandomString(length: Int.random(in: 6...16))
        let password = generateRandomString(length: Int.random(in: 6...16))
        
        let viewModel = LoginViewModel()
        viewModel.email = email
        viewModel.password = password
        viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid email.")
        
        
    }
    
    func test_LoginViewModel_login_succesfulLogin() {
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in:1...10))
        let viewModel = LoginViewModel(auth: MockFirebaseAuthServiceSuccess())
        
        viewModel.email = email
        viewModel.password = password
        viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage,"")
    }
    
    func test_LoginViewModel_login_failedLogin() {
        let email = "test@email.com"
        let password = generateRandomString(length: Int.random(in:1...10))
        let viewModel = LoginViewModel(auth: MockFirebaseAuthServiceFailed())
        
        viewModel.email = email
        viewModel.password = password
        viewModel.login()
        
        XCTAssertEqual(viewModel.errorMessage,"User does not exist")
    }

}
