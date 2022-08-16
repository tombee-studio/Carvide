//
//  RequestData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct RequestData: Codable, Identifiable {
    let id: Int
    let room_name: String
    let created: Data
    let title: String
    let description: String
    let intervals: Int
    let values: [PointData]
    let participants: [UserData]
    let is_able_to_send: Bool
    let content: ContentData
    let value_type: ValueTypeData
}
