//
//  Angle+Ext.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 20/3/2022.
//

import Foundation
import SwiftUI

extension Angle {
    /// Normalises angle to be between 0º - 360º
    var normalised: Angle {
        var angle = self
        
        while (angle >= .degrees(360)) {
            angle -= .degrees(360)
        }
        
        while (angle < .degrees(0)) {
            angle += .degrees(360)
        }
        
        return angle
    }
}
