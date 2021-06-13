//
//  ValidationServiceTest.swift
//  BrightskiesTestTests
//
//  Created by Maged Omar on 13/06/2021.
//

import XCTest
@testable import BrightskiesTest


class ValidationServiceTest: XCTestCase {

    var validation: ValidationService!

    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }

    override func tearDown() {
        validation = nil
        super.tearDown()
    }

    func testIsValidEmail() throws {
        XCTAssertNil(validation.emailValidationError("admin@admin.com"))
    }
    
    func testEmailNotValid() throws {
        XCTAssertNotNil(validation.emailValidationError("admin"))
    }
    
    
    func testEmailIsNil() throws {
        let expectedError = ValidationError.emailIsEmpty
        let  error = validation.emailValidationError("")
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)

    }

    func testPasswordTooShort() throws {
        // pasword Shuld be more than 7
        let expectedError = ValidationError.passwordTooShort
        let error = validation.passwordValidationError("123")
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
}
