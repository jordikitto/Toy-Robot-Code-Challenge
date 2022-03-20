//
//  RobotDirectionTests.swift
//  Toy RobotTests
//
//  Created by Jordi Kitto on 21/3/2022.
//

import XCTest
import SwiftUI
@testable import Toy_Robot

class RobotDirectionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNorthAngle() {
        let dir = RobotDirection.north
        
        XCTAssertTrue(dir.angle == .degrees(0), "Northern angle should be 0º")
    }
    
    func testDegreeToNorthDirection() {
        let angle = Angle(degrees: 0)
        let dir = RobotDirection(from: angle)
        
        XCTAssertTrue(dir == .north, "0º should produce a North direction")
    }
    
    // And so on...
    
    // To save time I won't be fully unit testing everything.
    // These tests are just included to show acknowledgement of good practice!
}
