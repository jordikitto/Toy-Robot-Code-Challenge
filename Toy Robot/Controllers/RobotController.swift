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
    @Published var state: RobotState = .nominal
    
    func moveForward() {
        let delta = direction.forwardDelta()
        xTile += delta.X
        yTile += delta.Y
        
        detectObstruction()
    }
    
    func turnRight() {
        angle += .degrees(90)
        direction = RobotDirection(from: angle)
        
        detectObstruction()
    }
    
    func turnLeft() {
        angle += .degrees(-90)
        direction = RobotDirection(from: angle)
        
        detectObstruction()
    }
    
    func detectObstruction() {
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
