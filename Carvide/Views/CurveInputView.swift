//
//  CurveInputView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/18.
//

import SwiftUI

struct CurveInputView: View {
    
    @State private var points: [PointData] = []
    
    let action: ([PointData]) -> Void
    
    init(points: [PointData], _ action: @escaping ([PointData]) -> Void) {
        self.points = points
        self.action = action
    }
    
    var body: some View {
        
    }
}

struct CurveInputView_Previews: PreviewProvider {
    static var previews: some View {
        CurveInputView(points: []) {_ in 
            
        }
    }
}
