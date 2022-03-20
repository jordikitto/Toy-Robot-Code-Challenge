//
//  MoveControlsView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct MoveControlsView: View {
    @EnvironmentObject var robotController: RobotController
    
    var body: some View {
        VStack {
            Text("Move")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                Button {
                    robotController.turnLeft()
                } label: {
                    Image(systemName: "arrow.uturn.down.circle.fill")
                        .font(.largeTitle)
                }
                .buttonStyle(.plain)
                
                Button {
                    robotController.moveForward()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                }
                .buttonStyle(.plain)
                .rotationEffect(robotController.angle)
                .animation(.linear, value: robotController.angle)
                .disabled(robotController.state == .obstructed)
                
                Button {
                    robotController.turnRight()
                } label: {
                    Image(systemName: "arrow.uturn.down.circle.fill")
                        .font(.largeTitle)
                        .rotation3DEffect(.degrees(180), axis: (0, 180, 0))
                }
                .buttonStyle(.plain)

            }
            
            Spacer()
            
            Button {
                print("Report!")
            } label: {
                Text("Report")
            }

            Text("Output of report will go here")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: 300)
    }
}

struct MoveControlsView_Previews: PreviewProvider {
    static var previews: some View {
        MoveControlsView()
    }
}
