//
//  ParkingAppTests.swift
//  ParkingAppTests
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import XCTest
@testable import ParkingApp

class ParkingAppTests: XCTestCase {

    var sut: Payment!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
       sut = Payment()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testPayment() throws {
        
        XCTAssertEqual(try sut.processPayment(for: 50, for: 50), "\(0.0) ZAR", "Test passed, R50.0 - R50.0 is R0.0")
        XCTAssertEqual(try sut.processPayment(for: 50, for: 30), "\(20.0) ZAR", "Tessed passed, R50.0 - R30.0 is R20.0")
        XCTAssertThrowsError(try sut.processPayment(for: 0, for: 10)) // test passes, error thrown when amount paying is Zero and bellow
        XCTAssertThrowsError(try sut.processPayment(for: 30, for: 50))// test passes, error thrown when amount paying is less than the amount duducting
    }
    

}
