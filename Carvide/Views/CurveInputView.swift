//
//  CurveInputView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/18.
//

import SwiftUI

struct CurveInputView: View {
    @State private var points: [PointData] = []
    @State private var currentPoints: [PointData] = []
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .border(Color.black, width: 1)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                            currentPoints.append(PointData(cgpoint: value.location))
                            currentPoints = currentPoints.sorted(by: { pointA, pointB in
                                pointA.x < pointB.x
                            })
                        })
                        .onEnded({ value in
                            currentPoints.append(PointData(cgpoint: value.location))
                            currentPoints = currentPoints.sorted { pointA, pointB in
                                pointA.x < pointB.x
                            }
                            mergePoints()
                            currentPoints = []
                        })
                )
            Path { path in
                path.addLines(points.map { CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) })
            }.stroke(Color.red, lineWidth: 3)
            
            Path { path in
                path.addLines(currentPoints.map { CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) })
            }.stroke(Color.blue, lineWidth: 3)
        }
    }
    
    func mergePoints() {
        print(currentPoints.count)
        let startX = currentPoints[0].x
        let endX = currentPoints[currentPoints.count - 1].x
        points = points.filter({ point in startX > point.x || point.x > endX })
        points += currentPoints
        points = points.sorted(by: { pointA, pointB in
            pointA.x < pointB.x
        })
    }
}

struct CurveInputView_Previews: PreviewProvider {
    static var previews: some View {
        CurveInputView()
    }
}
