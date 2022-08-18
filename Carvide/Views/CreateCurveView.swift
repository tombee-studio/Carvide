//
//  CreateCurveView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/16.
//

import SwiftUI

struct CreateCurveView: View {
    @State var isOpenCurveInputView: Bool = false
    
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
                if(isOpenCurveInputView) {
                    CurveInputView()
                }
            }.padding(5)
            HStack {
                ValueTypeView(value_type: valueType)
                    .alignmentGuide(.leading, computeValue: {d in d[.leading]})
                    .padding(20)
                Spacer()
                Button(action: {
                    isOpenCurveInputView.toggle()
                }) {
                    Image(systemName: "chart.xyaxis.line")
                        .resizable()
                        .frame(width: 48, height: 48)
                    Text("感情曲線を描く")
                        .bold()
                        .padding()
                        .frame(height: 84)
                        .cornerRadius(25)
                }.padding(20)
            }
        }
    }
}

struct CreateCurveView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCurveView(
            content: ContentData.createContentData(),
            valueType: ValueTypeData.createValueTypeData())
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
