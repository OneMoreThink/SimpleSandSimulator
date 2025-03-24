//
//  ContentView.swift
//  SimpleSandSimul
//
//  Created by 이종선 on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    let columns = 40
    let rows = 40
    let cellSize: CGFloat = 10
    
    // Grid의 각 cell의 상태 값 : 0 = empty, 1 = sand
    @State private var grid = Array(repeating: Array(repeating: 0, count: 40), count: 40)
    
    var body: some View {
        VStack {
            Text("모래 칠하기")
                .font(.largeTitle)
                .padding()
            
            Canvas { context, size in
                // 그리드 라인 그리기
                for row in 0...rows {
                    let y = CGFloat(row) * cellSize
                    
                    let startPoint = CGPoint(x: 0, y: y)
                    let endPoint = CGPoint(x: CGFloat(columns) * cellSize, y: y)
                    
                    var path = Path()
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                    context.stroke(path, with: .color(.gray), lineWidth: 0.5)
                }
                
                for column in 0...columns {
                    let x = CGFloat(column) * cellSize
                    
                    let startPoint = CGPoint(x: x, y: 0)
                    let endPoint = CGPoint(x: x, y: CGFloat(rows) * cellSize)
                    
                    var path = Path()
                    path.move(to: startPoint)
                    path.addLine(to: endPoint)
                    context.stroke(path, with: .color(.gray), lineWidth: 0.5)
                }
                
                // 모래 그리기
                for row in 0..<grid.count {
                    for column in 0..<(grid[row].count) {
                        if grid[row][column] == 1 {
                            let rect = CGRect(
                                x: CGFloat(column) * cellSize,
                                y: CGFloat(row) * cellSize,
                                width: cellSize,
                                height: cellSize
                            )
                            
                            context.fill(Path(rect), with: .color(.green))
                        }
                    }
                }
            }
            .frame(width: CGFloat(columns) * cellSize, height: CGFloat(rows) * cellSize)
            .background(Color.black)
            .border(Color.white)

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                initGrid()
            }
        }
    }
    
    private func initGrid() {
        var newGrid = Array(repeating: Array(repeating: 0, count: rows), count: columns)
        
        newGrid[10][20] = 1
        grid = newGrid
        
    }
}

#Preview {
    ContentView()
}
