//
//  CreateCurveView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/16.
//

import SwiftUI

struct CreateCurveView: View {
    @State private var points: [PointData] = []
    @State private var currentPoints: [PointData] = []
    
    let content: ContentData
    let valueType: ValueTypeData
    
    init(content: ContentData, valueType: ValueTypeData) {
        self.content = content
        self.valueType = valueType
    }
    
    var body: some View {
        VStack {
            ZStack {
                CurveVideoPlayer(content: content)
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
            }.padding(5)
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

struct CreateCurveView_Previews: PreviewProvider {
    static var previews: some View {
        let decoder = JSONDecoder()
        CreateCurveView(
            content: try! ContentData(from: decoder as! Decoder),
            valueType: try! ValueTypeData(from: decoder as! Decoder))
    }
}
