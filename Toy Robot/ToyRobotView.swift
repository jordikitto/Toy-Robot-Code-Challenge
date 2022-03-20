//
//  ContentView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct ToyRobotView: View {
    @StateObject var robotController = RobotController()
    
    var body: some View {
        VStack {
            HStack {
                GridLabel("Y")
                
                VStack {
                    GeometryReader { geometry in
                        ZStack(alignment: .bottomLeading) {
                            TableTopGridView()
                            RobotView()
                                .frame(width: tileSize(for: geometry), height: tileSize(for: geometry))
                                .rotationEffect(robotController.angle)
                                .position(x: xPosition(for: geometry), y: yPosition(for: geometry))
                                .offset(x: -geometry.size.width/12, y: geometry.size.height/12)
                                .animation(.linear, value: robotController.angle)
                                
                        }
                        .animation(.linear, value: robotController.yTile)
                        .animation(.linear, value: robotController.xTile)
                    }
                    .aspectRatio(1.0, contentMode: .fit)
                    
                    GridLabel("X")
                }
                
                VStack {
                    VStack {
                        Text("N")
                        Image(systemName: "location.north.line")
                    }
                    .font(.title)
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .padding()
            
            HStack {
                Spacer()
                PlaceControlsView()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: 15)
                    )
                    .padding()
                    
                Spacer()
                MoveControlsView()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(radius: robotController.state == .unplaced ? 5 : 15)
                    )
                    .padding()
                    .scaleEffect(robotController.state == .unplaced ? 0.9 : 1)
                    .disabled(robotController.state == .unplaced)
                    .animation(.easeInOut, value: robotController.state)
                Spacer()
            }
            .frame(maxHeight: 200)
            
        }
        .environmentObject(robotController)
    }
    
    /// Get the width/height of a tile based on the current view size
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: Width/height of a tile on table top
    func tileSize(for geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width/CGFloat(TABLE_SIZE)
    }
    
    /// Get the X position for the robot
    ///
    /// An X of 0 starts from the left of the view
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: X position of robot
    func xPosition(for geometry: GeometryProxy) -> CGFloat {
        return tileSize(for: geometry) * CGFloat(robotController.xTile)
    }
    
    /// Get the Y position for the robot
    ///
    /// An Y of 0 starts from the top of the view
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: Y position of robot
    func yPosition(for geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height - tileSize(for: geometry) * CGFloat(robotController.yTile)
    }
    
    func GridLabel(_ text: String) -> some View {
        Text(text)
            .font(.title)
            .foregroundColor(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToyRobotView()
            .frame(minWidth: 500, minHeight: 500)
    }
}
