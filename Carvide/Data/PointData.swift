//
//  PointData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import SwiftUI
import Foundation

struct PointData: Codable {
    let x: Float
    let y: Float
    let axis: String
    let type: String
    
    init() {
        self.x = 0
        self.y = 0
        self.axis = ""
        self.type = ""
    }
    
    init(cgpoint: CGPoint) {
        self.x = Float(cgpoint.x)
        self.y = Float(cgpoint.y)
        self.axis = ""
        self.type = ""
    }
}

