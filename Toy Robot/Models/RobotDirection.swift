//
//  RobotDirection.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import Foundation
import SwiftUI

enum RobotDirection: String, Equatable, CaseIterable {
    case north = "North"
    case east = "East"
    case south = "South"
    case west = "West"
    
    // MARK: Initialisers
    
    init(from inputAngle: Angle) {
        var angle = inputAngle
        
        // Bring within 0 - 360
        while (angle >= .degrees(360)) {
            angle -= .degrees(360)
        }
        
        while (angle < .degrees(0)) {
            angle += .degrees(360)
        }
        
        // Convert to direction
        let offset: Angle = .degrees(45) // Used to ensure small variance below the threshold rounds to a likely correct number
        if (angle >= .degrees(360) - offset) {
            self.init(rawValue: RobotDirection.north.rawValue)!
        } else  if (angle >= .degrees(270) - offset) {
            self.init(rawValue: RobotDirection.west.rawValue)!
        } else if (angle >= .degrees(180) - offset) {
            self.init(rawValue: RobotDirection.south.rawValue)!
        } else if (angle >= .degrees(90) - offset) {
            self.init(rawValue: RobotDirection.east.rawValue)!
        } else {
            self.init(rawValue: RobotDirection.north.rawValue)!
        }
    }
    
    // MARK: Variables
    
    var name: String {
        get {
            rawValue
        }
    }
    
    var angle: Angle {
        switch self {
        case .north:
            return .degrees(0)
        case .east:
            return .degrees(90)
        case .south:
            return .degrees(180)
        case .west:
            return .degrees(270)
        }
    }
    
    var directionToRight: RobotDirection {
        switch self {
        case .north:
            return .east
        case .east:
            return .south
        case .south:
            return .west
        case.west:
            return .north
        }
    }
    
    var directionToLeft: RobotDirection {
        switch self {
        case .north:
            return .west
        case .east:
            return .north
        case .south:
            return .east
        case.west:
            return .south
        }
    }
    
    // MARK: Functions
    
    func forwardDelta() -> (X: Int, Y: Int) {
        switch self {
        case .north:
            return (0, 1)
        case .south:
            return (0, -1)
        case .east:
            return (1, 0)
        case .west:
            return (-1, 0)
        }
    }
    

}
