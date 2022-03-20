//
//  RobotDirection.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import Foundation
import SwiftUI

/// Used to handle the directions the robot can face
enum RobotDirection: String, Equatable, CaseIterable {
    case north = "North"
    case east = "East"
    case south = "South"
    case west = "West"
    
    // MARK: Initialisers
    
    /// Generate a direction given an Angle
    /// - Parameter inputAngle: An angle
    init(from inputAngle: Angle) {
        let angle = inputAngle.normalised
        
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
    
    /// Human readable name
    var name: String {
        get {
            rawValue
        }
    }
    
    /// Anlge of the direction in degrees
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
    
    /// Direction that would result from a turn to the next direction to the right
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
    
    /// Direction that would result from a turn to the next direction to the left
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
    
    /// Direction that would result from a 180º turn
    var opposite: RobotDirection {
        switch self {
        case .north:
            return .south
        case .east:
            return .west
        case .south:
            return .north
        case .west:
            return .east
        }
    }
    
    // MARK: Functions
    
    /// Calculates the change in X,Y given a forward move
    /// - Returns: Delta of X, Y
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
    
    /// Calculates the change needed to reach the given direction
    ///
    /// This was created to stop the scenario of where going from West -> North could happen from a 270º turn to the left instead of a 90º turn to the right, which looks more natural.
    /// - Parameter newDirection: Direction to move to
    /// - Returns: Delta required to reach new direction
    func delta(to newDirection: RobotDirection) -> Angle {
        if (self == newDirection) {
            return .degrees(0)
        } else if (self.opposite == newDirection) {
            return .degrees(180)
        } else if (self.directionToLeft == newDirection) {
            return .degrees(-90)
        } else if (self.directionToRight == newDirection) {
            return .degrees(90)
        } else {
            // Fallback that I'm pretty sure should never happen, but just incase
            return newDirection.angle - self.angle
        }
    }

}
