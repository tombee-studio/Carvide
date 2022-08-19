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
    let created: String
    let title: String
    let description: String
    let intervals: Int
    let values: [PointData]
    let participants: [UserData]
    let is_able_to_send: Bool
    let content: ContentData
    let value_type: ValueTypeData
    let owner: UserData
    let expiration_date: String
    
    static func createRequestData() -> RequestData {
        let request = RequestData(
            id: 0,
            room_name: "axrgPd",
            created: "",
            title:"テストタイトル",
            description: "テスト説明テストディスクリプションテスト説明テストディスクリプションテスト説明テストディスクリプション",
            intervals: 0,
            values: [],
            participants: [],
            is_able_to_send: false,
            content: ContentData.createContentData(),
            value_type: ValueTypeData.createValueTypeData(),
            owner: UserData.createGuestUserData(),
            expiration_date: ""
        )
        return request
    }
}
