//
//  TableTopGridView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct TableTopGridView: View {
    /// Width of a grid line
    let lineWidth: CGFloat = 5
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.brown)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .shadow(radius: 15)
                Rectangle()
                    .stroke(Color.black, lineWidth: lineWidth)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                ForEach(1...TABLE_SIZE - 1, id: \.self) { index in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: geometry.size.width, height: lineWidth)
                        .offset(y: tileOffset(for: geometry.size.height, at: index))
                }
                
                ForEach(1...TABLE_SIZE - 1, id: \.self) { index in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: lineWidth, height: geometry.size.width)
                        .offset(x: tileOffset(for: geometry.size.height, at: index))
                }
            }
        }
    }
    
    /// How far to offset each tile
    /// - Parameters:
    ///   - length: Total length of all tiles
    ///   - index: Index of current tile
    /// - Returns: Tile offset length
    func tileOffset(for length: CGFloat, at index: Int) -> CGFloat {
        return length * (1/CGFloat(TABLE_SIZE) * CGFloat(index)) - lineWidth/2
    }
}

struct TableTopGridView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TableTopGridView()
                .frame(width: 1000, height: 1000)
            TableTopGridView()
                .frame(width: 500, height: 500)
        }
        .padding()
    }
}
