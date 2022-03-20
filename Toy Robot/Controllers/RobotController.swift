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
    
    func place(newX: Int? = nil, newY: Int? = nil) {
        state = .nominal
        
        if let x = newX {
            xTile = x
        }
        if let y = newY {
            yTile = y
        }
        
        detectObstruction()
    }
    
    func moveForward() {
        let delta = direction.forwardDelta()
        xTile += delta.X
        yTile += delta.Y
        
        detectObstruction()
    }
    
    func turnRight() {
        angle += .degrees(90)
        updateDirection()
    }
    
    func turnLeft() {
        angle += .degrees(-90)
        updateDirection()
    }
    
    func updateDirection() {
        direction = RobotDirection(from: angle)
        detectObstruction()
    }
    
    func updateDirection(_ newDirection: RobotDirection) {
        angle += direction.delta(to: newDirection)
        updateDirection()
    }
    
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
