//
//  PlaceControlsView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct PlaceControlsView: View {
    @ObservedObject var playerRobot: RobotController
    @ObservedObject var previewRobot: RobotController
    
    @State var direction: RobotDirection = .north
    @State var xTile = 1
    @State var yTile = 1
    
    @Binding var showPlacementPreview: Bool
    
    var body: some View {
        VStack {
            Text("Place")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                XTilePicker()
                YTilePicker()
            }
            
            DirectionPicker()
            
            Spacer()
            
            PlaceButton()
        }
        .frame(maxWidth: 300)
    }
    
    // MARK: Subviews
    
    func XTilePicker() -> some View {
        Picker(selection: $xTile) {
            ForEach(1...TABLE_SIZE, id: \.self) { index in
                Text("\(index-1)")
            }
        } label: {
            Text("X")
        }
        .onChange(of: xTile) { newX in
            previewRobot.xTile = newX
            
            if (playerRobot.state == .unplaced) {
                playerRobot.xTile = newX
            } else {
                previewRobot.yTile = yTile
                showPlacementPreview = true
            }
        }
    }
    
    func YTilePicker() -> some View {
        Picker(selection: $yTile) {
            ForEach(1...TABLE_SIZE, id: \.self) { index in
                Text("\(index-1)")
            }
        } label: {
            Text("Y")
        }
        .onChange(of: yTile) { newY in
            previewRobot.yTile = newY // Keep updated
            
            if (playerRobot.state == .unplaced) {
                playerRobot.yTile = newY
            } else {
                previewRobot.xTile = xTile
                showPlacementPreview = true
            }
        }
    }
    
    func DirectionPicker() -> some View {
        Picker(selection: $direction) {
            ForEach(RobotDirection.allCases, id: \.self) { dir in
                Text(dir.name)
                    .tag(dir.name)
            }
        } label: {
            Text("Direction")
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .onChange(of: direction) { newDirection in
            playerRobot.updateDirection(newDirection)
        }
        .onChange(of: playerRobot.direction, perform: { newDirection in
            direction = newDirection
        })
        .disabled(playerRobot.state != .unplaced)
    }
    
    func PlaceButton() -> some View {
        Button {
            if (playerRobot.state == .unplaced) {
                playerRobot.place()
            } else {
                showPlacementPreview = false
                playerRobot.place(newX: xTile, newY: yTile)
            }
        } label: {
            Text("Place")
        }
    }
}

struct PlaceControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceControlsView(
            playerRobot: RobotController(),
            previewRobot: RobotController(),
            showPlacementPreview: .constant(false)
        )
    }
}
