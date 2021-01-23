//
//  ParkingHourTests.swift
//  ParkingHourTests
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import XCTest
@testable import ParkingApp

class ParkingHourTests: XCTestCase {

    var sut: PayForParkingViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PayForParkingViewController()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func testParkingAmountDeducting() throws {
        
        
        XCTAssertEqual(sut.calculateAmountDeducting(for: 0), 10.0)
        XCTAssertEqual(sut.calculateAmountDeducting(for: 1), 10.0)
        XCTAssertEqual(sut.calculateAmountDeducting(for: 2), 10.0)
        
        XCTAssertEqual(sut.calculateAmountDeducting(for: 3), 20.0)
        XCTAssertEqual(sut.calculateAmountDeducting(for: 4), 20.0)
        
        XCTAssertEqual(sut.calculateAmountDeducting(for: 5), 30.0)
        XCTAssertEqual(sut.calculateAmountDeducting(for: 6), 30.0)
        
        XCTAssertEqual(sut.calculateAmountDeducting(for: 7), 40.0)
        XCTAssertEqual(sut.calculateAmountDeducting(for: 8), 40.0)
        
        XCTAssertEqual(sut.calculateAmountDeducting(for: 9), 50.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
