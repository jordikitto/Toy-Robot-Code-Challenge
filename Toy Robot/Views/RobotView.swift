//
//  RobotView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct RobotView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    Wheel(geometry, xPosition: 0.15)
                    Wheel(geometry, xPosition: 0.85)
                }
                Circle()
                    .fill(Color.black)
                    .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.85)
                Image(systemName: "arrow.up.circle")
                    .resizable()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                    .foregroundColor(.purple)
            }
        }
    }
    
    // MARK: Subviews
    
    func Wheel(_ geometry: GeometryProxy, xPosition: CGFloat) -> some View {
        Capsule()
            .fill(Color.black)
            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.8)
            .position(x: geometry.size.width * xPosition, y: geometry.size.height * 0.5)
    }
}

struct RobotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RobotView()
                .frame(width: 100, height: 100)
            RobotView()
                .frame(width: 300, height: 300)
            RobotView()
                .frame(width: 600, height: 600)
        }
    }
}
