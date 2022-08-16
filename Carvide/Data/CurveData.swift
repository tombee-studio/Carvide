//
//  CurveData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct CurveData: Codable, Identifiable {
    let id: Int
    let created: String
    let values: [PointData]
    let version: String
    let room_name: String
    let locked: Bool
    let user: UserData
    let content: ContentData
    let value_type: ValueTypeData
}
