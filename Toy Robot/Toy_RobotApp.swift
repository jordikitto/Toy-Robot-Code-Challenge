//
//  Toy_RobotApp.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

@main
struct Toy_RobotApp: App {    
    var body: some Scene {
        WindowGroup {
            ToyRobotView()
                .frame(minWidth: 450, minHeight: 500)
        }
    }
}
