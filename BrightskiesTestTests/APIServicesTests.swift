//
//  APIServicesTests.swift
//  BrightskiesTestTests
//
//  Created by Maged Omar on 13/06/2021.
//

import XCTest
import Alamofire
@testable import BrightskiesTest

class APIServicesTests: XCTestCase {

    override func setUp(){
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetListOfRecipes(){
        
        let expectation = self.expectation(description: "Get List Of Recipes expectation")
        let url = "https://api.npoint.io/43427003d33f1f6b51cc"
        AF.request(url).responseDecodable(of: RecipesResponseModel.self) { response in
            let error = response.error
            XCTAssertNil(error)
            XCTAssertNotNil(response.value)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }
    
    func testServiceNotValid(){
        let expectation = self.expectation(description: "Invalid Serveces expectation")
        let url = "https://api.npoint.io/43427003d33f1f6b51" // invalid URL
        AF.request(url).responseDecodable(of: RecipesResponseModel.self) { response in
            let error = response.error
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }
}
