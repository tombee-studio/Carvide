//
//  CreateCurveView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/16.
//

import SwiftUI

struct CreateCurveView: View {
    @State private var points: [PointData] = []
    
    let content: ContentData
    let valueType: ValueTypeData
    
    init(content: ContentData, valueType: ValueTypeData) {
        self.content = content
        self.valueType = valueType
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .border(Color.black, width: 1)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({ value in
                                points.append(PointData(point: value.location))
                                points = points.sorted { pointA, pointB in
                                    pointA.x < pointB.x
                                }
                            })
                            .onEnded({ value in
                                points.append(PointData(point: value.location))
                                points = points.sorted { pointA, pointB in
                                    pointA.x < pointB.x
                                }
                            })
                    )
                
                // 追加ずみのLineの描画
                Path { path in
                    path.addLines(points.map { CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) })
                }.stroke(Color.red, lineWidth: 1)
                
            }.padding(5)
        }
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
