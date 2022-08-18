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
                Group {
                    Button(action: {
                        isOpenCurveInputView.toggle()
                    }) {
                        Text("感情曲線入力画面を開く")
                            .bold()
                            .padding()
                            .frame(height: 84)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
            }.padding(5)
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
