//
//  Toy_RobotTests.swift
//  Toy RobotTests
//
//  Created by Jordi Kitto on 17/3/2022.
//

import XCTest
import SwiftUI
@testable import Toy_Robot

class AngleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositive() {
        let angle = Angle(degrees: 450)
        
        XCTAssertTrue(angle.normalised == .degrees(90), "Normalised angle should be 90º")
    }
    
    func testLargePositive() {
        let angle = Angle(degrees: 1440)
        
        XCTAssertTrue(angle.normalised == .degrees(0), "Normalised angle should be 0º")
    }
    
    func testNegative() {
        let angle = Angle(degrees: -90)
        
        XCTAssertTrue(angle.normalised == .degrees(270), "Normalised angle should be 270º")
    }
}
