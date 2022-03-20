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
                    Capsule()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.8)
                        .position(x: geometry.size.width * 0.15, y: geometry.size.height * 0.5)
                    Capsule()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.8)
                        .position(x: geometry.size.width * 0.85, y: geometry.size.height * 0.5)
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
