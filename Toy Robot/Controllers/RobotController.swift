//
//  RobotController.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import Foundation
import SwiftUI

class RobotController: ObservableObject {
    @Published var xTile = 1
    @Published var yTile = 1
    @Published var direction: RobotDirection = .north
    @Published var angle: Angle = .degrees(0)
    @Published var state: RobotState = .unplaced
    
    /// Place the robot at its current position, of a given position
    /// - Parameters:
    ///   - newX: Optional X tile position
    ///   - newY: Optional Y tile position
    func place(newX: Int? = nil, newY: Int? = nil) {
        if (state == .unplaced) {
            state = .nominal
        }
        
        if let x = newX {
            xTile = x
        }
        if let y = newY {
            yTile = y
        }
        
        detectObstruction()
    }
    
    /// Move the robot forward in the current direction
    func moveForward() {
        let delta = direction.forwardDelta()
        xTile += delta.X
        yTile += delta.Y
        
        detectObstruction()
    }
    
    /// Turn right without movement
    func turnRight() {
        angle += .degrees(90)
        updateDirection()
    }
    
    /// Turn left without movement
    func turnLeft() {
        angle += .degrees(-90)
        updateDirection()
    }
    
    
    /// Redetermine direction robot is facing from angle it currently has
    func updateDirection() {
        direction = RobotDirection(from: angle)
        detectObstruction()
    }
    
    /// Set robot to face towards a new direction
    func updateDirection(_ newDirection: RobotDirection) {
        angle += direction.delta(to: newDirection)
        updateDirection()
    }
    
    /// Detect if the robot cannot move forward because it is obstructed (e.g. by end of table)
    func detectObstruction() {
        guard state != .unplaced else { return }
        
        let delta = direction.forwardDelta()
        let nextXTile = xTile + delta.X
        let nextYTile = yTile + delta.Y
        
        if (nextXTile < 1 || nextXTile > TABLE_SIZE) {
            state = .obstructed
        } else if (nextYTile < 1 || nextYTile > TABLE_SIZE) {
            state = .obstructed
        } else {
            state = .nominal
        }
    }
}
