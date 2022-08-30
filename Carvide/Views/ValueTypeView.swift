//
//  ValueTypeView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/19.
//

import SwiftUI

struct ValueTypeView: View {
    let value_type: ValueTypeData
    
    init(value_type: ValueTypeData) {
        self.value_type = value_type
    }
    
    var body: some View {
        Text(value_type.title)
    }
}

struct ValueTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ValueTypeView(value_type: ValueTypeData.createValueTypeData())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
