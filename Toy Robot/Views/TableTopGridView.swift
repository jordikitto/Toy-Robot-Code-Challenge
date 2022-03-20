//
//  TableTopGridView.swift
//  Toy Robot
//
//  Created by Jordi Kitto on 17/3/2022.
//

import SwiftUI

struct TableTopGridView: View {
    let lineWidth: CGFloat = 5
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
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