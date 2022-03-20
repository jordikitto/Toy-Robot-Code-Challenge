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
    
    let size = 6
    
    var body: some View {
        VStack {
            Text("Place")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                Picker(selection: $robotController.xTile) {
                    ForEach(1...TABLE_SIZE, id: \.self) { index in
                        Text("\(index)")
                    }
                } label: {
                    Text("X")
                }
                
                Picker(selection: $robotController.yTile) {
                    ForEach(1...TABLE_SIZE, id: \.self) { index in
                        Text("\(index)")
                    }
                } label: {
                    Text("Y")
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
            .disabled(robotController.state != .unplaced)
            
            Spacer()
            
            Button {
                robotController.place()
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
