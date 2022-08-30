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
    @State var isOpenCurveInputView: Bool = false
    
    let request: RequestData
    let content: ContentData
    let valueType: ValueTypeData
    
    init(request: RequestData) {
        self.request = request
        self.content = request.content
        self.valueType = request.value_type
    }
    
    var body: some View {
        VStack {
            ZStack {
                CurveVideoPlayer(content: content)
                if(isOpenCurveInputView) {
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
                                        let startX = currentPoints[0].x
                                        let endX = currentPoints[currentPoints.count - 1].x
                                        points = points.filter({ point in startX > point.x || point.x > endX })
                                        points += currentPoints
                                        points = points.sorted(by: { pointA, pointB in
                                            pointA.x < pointB.x
                                        })
                                        currentPoints = []
                                    })
                            )
                        Path { path in
                            path.addLines(points.map {
                                CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) })
                        }.stroke(Color.red, lineWidth: 3)
                        
                        Path { path in
                            path.addLines(currentPoints.map {
                                CGPoint(x: CGFloat($0.x), y: CGFloat($0.y)) })
                        }.stroke(Color.blue, lineWidth: 3)
                    }
                }
            }.padding(5)
            HStack {
                ValueTypeView(value_type: valueType)
                    .alignmentGuide(.leading, computeValue: {d in d[.leading]})
                    .padding(20)
                Spacer()
                HStack {
                    Button(action: {
                        isOpenCurveInputView.toggle()
                    }) {
                        Image(systemName: "chart.xyaxis.line")
                            .resizable()
                            .frame(width: 48, height: 48)
                        Text("描画")
                            .bold()
                            .padding()
                            .frame(height: 84)
                    }.padding(20)
                    Button(action: {
                        Task.init {
                            let model = EmonotateModel()
                            if let user = await model.getMe() {
                                let curveData = CurveData(
                                    id: 0,
                                    created: "",
                                    values: points,
                                    version: "1.0.0",
                                    room_name: request.room_name,
                                    locked: true,
                                    user: user, content: content, value_type: valueType)
                                let data = await model.createCurveData(curve: curveData)
                                print(data)
                            }
                        }
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 48, height: 48)
                        Text("保存")
                            .bold()
                            .padding()
                            .frame(height: 84)
                    }.padding(20)
                }
            }
        }
    }
}

struct CreateCurveView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCurveView(request: RequestData.createRequestData())
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
