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
    
    // Timer for simulation updates
    @State private var timer: Timer?
    @State private var isPaused: Bool = false
    
    var body: some View {
        VStack {
            Text("모래 떨어뜨리기")
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
            
            HStack{
                Button(isPaused ? "Resume" :"Pause"){
                    isPaused.toggle()
                    if isPaused{
                        timer?.invalidate()
                    }else {
                        startSimulation()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                initGrid()
                startSimulation()
            }
        }
        .onDisappear {
            // 타이머 정리
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func initGrid() {
        var newGrid = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        newGrid[10][20] = 1
        grid = newGrid
    }
    
    private func startSimulation() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            updateGrid()
        })
    }
    
    func updateGrid() {
        // 아래에서부터 위로 검사해야 모래가 한 프레임에 여러 칸 떨어지는 것을 방지할 수 있음
        for row in (0..<rows-1).reversed() {
            for column in 0..<columns {
                if grid[row][column] == 1 {
                    // 아래 칸이 비어있는지 확인
                    if grid[row+1][column] == 0 {
                        // 모래를 아래로 이동
                        grid[row][column] = 0
                        grid[row+1][column] = 1
                    }
                    // 아래칸이 막혀 있다면 아래 대각선 방향으로 이동 시도
                    else if column > 0 && grid[row+1][column-1] == 0 {
                        // 왼쪽 아래 대각선으로 이동
                        grid[row][column] = 0
                        grid[row+1][column-1] = 1
                    }
                    else if column < columns-1 && grid[row+1][column+1] == 0 {
                        // 오른쪽 아래 대각선으로 이동
                        grid[row][column] = 0
                        grid[row+1][column+1] = 1
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
