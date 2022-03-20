//
//  ContentView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct ToyRobotView: View {
    /// Robot controlled by player
    @StateObject var playerRobot = RobotController()
    /// Robot used to preview position for placement
    @StateObject var previewRobot = RobotController()
    
    /// Whether the preview robot should show or not, since it acts as the placement preview
    @State var showPlacementPreview = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TableTop()
                .padding()
            
            Controls()
                .frame(maxHeight: 200)
            
        }
        .onAppear() {
            previewRobot.state = .nominal
        }
    }
    
    // MARK: SubViews
    
    func Controls() -> some View {
        HStack {
            Spacer()
            
            PlaceControlsView(
                playerRobot: playerRobot,
                previewRobot: previewRobot,
                showPlacementPreview: $showPlacementPreview
            )
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .shadow(radius: 15)
                )
                .padding()
                
            Spacer()
            
            MoveControlsView(playerRobot: playerRobot)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .shadow(radius: playerRobot.state == .unplaced ? 5 : 15)
                )
                .padding()
                .scaleEffect(playerRobot.state == .unplaced ? 0.9 : 1)
                .disabled(playerRobot.state == .unplaced)
                .animation(.easeInOut, value: playerRobot.state)
            
            Spacer()
        }
    }
    
    func TableTop() -> some View {
        HStack {
            GridLabel("Y")
        
            VStack {
                Grid()
                GridLabel("X")
            }
            
            VStack {
                NorthIcon()
                Spacer()
            }
        }
    }
    
    func Grid() -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TableTopGridView()
                Robot(on: geometry, controlledBy: previewRobot)
                    .opacity(showPlacementPreview ? 0.5 : 0)
                    .animation(.linear, value: showPlacementPreview)
                    .onChange(of: playerRobot.xTile) { playerX in
                        previewRobot.xTile = playerX
                        previewRobot.yTile = playerRobot.yTile
                    }
                    .onChange(of: playerRobot.yTile) { playerY in
                        previewRobot.xTile = playerRobot.xTile
                        previewRobot.yTile = playerY
                    }
                    .onChange(of: playerRobot.angle) { newAngle in
                        previewRobot.angle = newAngle
                    }
                Robot(on: geometry, controlledBy: playerRobot)
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
    
    func Robot(on geometry: GeometryProxy, controlledBy robot: RobotController) -> some View {
        RobotView()
            .frame(
                width: robotSize(for: geometry, for: robot.state),
                height: robotSize(for: geometry, for: robot.state)
            )
            .rotationEffect(robot.angle)
            .position(
                x: xPosition(for: geometry, for: robot),
                y: yPosition(for: geometry, for: robot)
            )
            .offset(
                x: -geometry.size.width/CGFloat((TABLE_SIZE*2)),
                y: geometry.size.height/CGFloat((TABLE_SIZE*2))
            ) // Offset by half a tile, to bring robot to center of tile
            .shadow(radius: robot.state == .unplaced ? 25 : 0)
            .animation(.linear, value: robot.angle)
            .animation(.easeInOut, value: robot.state)
            .animation(.easeInOut, value: robot.yTile)
            .animation(.easeInOut, value: robot.xTile)
    }
    
    func GridLabel(_ text: String) -> some View {
        Text(text)
            .font(.title)
            .foregroundColor(.gray)
    }
    
    func NorthIcon() -> some View {
        VStack {
            Text("N")
            Image(systemName: "location.north")
        }
        .font(.title)
        .foregroundColor(.gray)
    }
    
    // MARK: Helpers
    
    /// Get the width/height of a tile based on the current view size
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: Width/height of a tile on table top
    func tileSize(for geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width/CGFloat(TABLE_SIZE)
    }
    
    /// Get the width/height of the robot based on the current view size
    /// - Parameters:
    ///   - geometry: Geometry of table top view
    ///   - state: State of the robot
    /// - Returns: Width/height of the robot
    func robotSize(for geometry: GeometryProxy, for state: RobotState) -> CGFloat {
        return tileSize(for: geometry) + (state == .unplaced ? 25 : 0)
    }
    
    /// Get the X position for the robot
    ///
    /// An X of 0 starts from the left of the view
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: X position of robot
    func xPosition(for geometry: GeometryProxy, for robot: RobotController) -> CGFloat {
        return tileSize(for: geometry) * CGFloat(robot.xTile)
    }
    
    /// Get the Y position for the robot
    ///
    /// An Y of 0 starts from the top of the view
    /// - Parameter geometry: Geometry of table top view
    /// - Returns: Y position of robot
    func yPosition(for geometry: GeometryProxy, for robot: RobotController) -> CGFloat {
        return geometry.size.height - tileSize(for: geometry) * CGFloat(robot.yTile)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToyRobotView()
            .frame(minWidth: 500, minHeight: 500)
    }
}
