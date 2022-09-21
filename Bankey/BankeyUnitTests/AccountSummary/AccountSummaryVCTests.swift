//
//  AccountSummaryVCTests.swift
//  BankeyUnitTests
//
//  Created by Bryan Yong on 21/09/2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryVCTests : XCTestCase {
    
    var vc: AccountSummaryVC!
    var mockManager : MockProfileManager!
    
    class MockProfileManager : ProfileManageable {
        var profile : Profile?
        var error : NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
            }
            profile = Profile(id: "1", firstName: "John", lastName: "Smith")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryVC()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testShouldBeVisible() throws {
        
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = .serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = .decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
}
