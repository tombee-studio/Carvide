//
//  CurveType.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct ValueTypeData: Codable, Identifiable {
    enum AxisType: Int, Codable {
        case MID_ZERO = 1
        case MIN_ZERO = 2
    }
    
    let id: Int
    let created: String
    let title: String
    let axis_type: AxisType
}
