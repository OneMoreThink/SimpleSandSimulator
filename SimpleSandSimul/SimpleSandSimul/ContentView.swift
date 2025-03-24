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
                // 모래와 그리드를 한 번에 그리기
                for row in 0..<rows {
                    let y = CGFloat(row) * cellSize
                    
                    for column in 0..<columns {
                        let x = CGFloat(column) * cellSize
                        let rect = CGRect(
                            x: x,
                            y: y,
                            width: cellSize,
                            height: cellSize
                        )
                        
                        // 모래 채우기 (더 먼저 그려서 그리드 라인이 위에 오도록)
                        if grid[row][column] == 1 {
                            context.fill(Path(rect), with: .color(.green))
                        }
                        
                        // 셀 테두리 그리기 (각 셀의 테두리만 그림)
                        var cellPath = Path()
                        cellPath.addRect(rect)
                        context.stroke(cellPath, with: .color(.gray), lineWidth: 0.5)
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
        var newGrid = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        newGrid[10][20] = 1
        grid = newGrid
    }
}

#Preview {
    ContentView()
}
