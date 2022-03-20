//
//  PlaceControlsView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct PlaceControlsView: View {
    @EnvironmentObject var robotController: RobotController
    
    @State var direction: RobotDirection = .north
    @State var xTile = 1
    @State var yTile = 1
    
    let size = 6
    
    var body: some View {
        VStack {
            Text("Place")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                Picker(selection: $xTile) {
                    ForEach(1...TABLE_SIZE, id: \.self) { index in
                        Text("\(index)")
                    }
                } label: {
                    Text("X")
                }
                .onChange(of: xTile) { newX in
                    if (robotController.state == .unplaced) {
                        robotController.xTile = newX
                    }
                }
                
                Picker(selection: $yTile) {
                    ForEach(1...TABLE_SIZE, id: \.self) { index in
                        Text("\(index)")
                    }
                } label: {
                    Text("Y")
                }
                .onChange(of: yTile) { newY in
                    if (robotController.state == .unplaced) {
                        robotController.yTile = newY
                    }
                }
            }
            
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
                robotController.updateDirection(newDirection)
            }
            .onChange(of: robotController.direction, perform: { newDirection in
                direction = newDirection
            })
            .disabled(robotController.state != .unplaced)
            
            Spacer()
            
            Button {
                if (robotController.state == .unplaced) {
                    robotController.place()
                } else {
                    robotController.place(newX: xTile, newY: yTile)
                }
            } label: {
                Text("Place")
            }
        }
        .frame(maxWidth: 300)
    }
}

struct PlaceControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceControlsView()
    }
}
