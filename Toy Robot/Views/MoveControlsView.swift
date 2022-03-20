//
//  MoveControlsView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct MoveControlsView: View {
    @ObservedObject var playerRobot: RobotController
    
    @State private var showReport = false
    
    var body: some View {
        VStack {
            Text("Move")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                MovementButton(playerRobot.turnLeft, symbol: "arrow.uturn.down.circle.fill")
                
                MovementButton(playerRobot.moveForward, symbol: "arrow.up.circle.fill")
                    .rotationEffect(playerRobot.angle)
                    .animation(.linear, value: playerRobot.angle)
                    .disabled(playerRobot.state == .obstructed)
                
                MovementButton(playerRobot.turnRight, symbol: "arrow.uturn.down.circle.fill")
                    .rotation3DEffect(.degrees(180), axis: (0, 180, 0))
            }
            
            Spacer()
            
            Button {
                showReport = true
            } label: {
                Text("Report")
            }
        }
        .frame(maxWidth: 300)
        .alert("Report", isPresented: $showReport) {
            Button {
                showReport = false
            } label: {
                Text("Ok")
            }
        } message: {
            Text("X Position: \(playerRobot.xTile-1)\nY Position: \(playerRobot.yTile-1)\nDirection: \(playerRobot.direction.name)")
        }

    }
    
    func MovementButton(_ action: @escaping () -> Void, symbol: String) -> some View {
        Button(action: action, label: {
            Image(systemName: symbol)
                .font(.largeTitle)
        })
        .buttonStyle(.plain)
    }
}

struct MoveControlsView_Previews: PreviewProvider {
    static var previews: some View {
        MoveControlsView(playerRobot: RobotController())
    }
}
