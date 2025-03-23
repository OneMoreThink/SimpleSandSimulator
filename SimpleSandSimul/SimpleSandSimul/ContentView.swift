//
//  ContentView.swift
//  SimpleSandSimul
//
//  Created by 이종선 on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    /// Celluar automata를 구성하는 격자의 속성(수, 크기)를 상수로 정의
    let columns = 40
    let rows = 40
    let cellSize: CGFloat = 10
    
    var body: some View {
        VStack {
            Text("격자 화면")
                .font(.largeTitle)
                .padding()
            /// Canvas는 SwiftUI에서 저수준 그래픽 작업을 지원하는 View
            /// context: Canvas 가 정의하는 View상에 그래픽 작업(그리기)를 수행하는 객체
            /// size: Canvas가 현재 View 계층에서 차지하는 size를 반환
            Canvas { context, size in
                // 격자의 가로선을 그립니다. (row 수 + 1)
                for row in 0...rows {
                    // 현재 행의 y 좌표 값을 계산
                    let y = CGFloat(row) * cellSize
                    
                    // 현재 그을 가로선의 시작점과 끝점을 정의
                    // 선의 왼쪽 끝 (x=0, y=현재행위치)
                    let startPoint = CGPoint(x: 0, y: y)
                    // 선의 오른쪽 끝 (x=격자의총너비, y=현재행위치)
                    let endPoint = CGPoint(x: CGFloat(columns) * cellSize, y: y)
                    
                    // 선을 그리기 위한 경로 객체 생성
                    var path = Path()
                    // 경로의 시작점 설정
                    path.move(to: startPoint)
                    // 현재 위치에서 지정된 점까지 직선을 추가
                    path.addLine(to: endPoint)
                    // context를 사용 canvas 상에
                    // 앞서 설정한 경로를 그린다.
                    context.stroke(path, with: .color(.gray), lineWidth: 0.5)
                }
                // 격자의 세로선을 그립니다. (column 수 + 1)
                for column in 0...columns {
                    // 현재 열의 x 좌표값 계산
                    let x = CGFloat(column) * cellSize
                    
                    // 세로선의 시작점과 끝점을 정의
                    // 선의 위쪽 끝 (x=현재열위치, y=0)
                    let startPoint = CGPoint(x: x, y: 0)
                    // 선의 아래쪽 끝 (x=현재열위치, y=격자의총높이)
                    let endPoint = CGPoint(x: x, y: CGFloat(rows) * cellSize)
                    
                    // 선을 그리기 위한 경로 객체 생성
                    var path = Path()
                    //  경로의 시작점 설정
                    path.move(to: startPoint)
                    // 현재 위치에서 지정된 점까지 직선을 추가
                    path.addLine(to: endPoint)
                    // context를 사용 canvas 상에
                    // 앞서 설정한 경로를 그린다.
                    context.stroke(path, with: .color(.gray), lineWidth: 0.5)
                }
            }
            // frame을 이용해 Canvas size 지정하기
            .frame(width: CGFloat(columns) * cellSize, height: CGFloat(rows) * cellSize)
            // Canvas 배경색상 설정
            .background(Color.black)
            // Canvas 테두리 설정 
            .border(Color.white)
            
        }
    }
}


#Preview {
    ContentView()
}
