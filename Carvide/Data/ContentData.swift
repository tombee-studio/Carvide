//
//  ContentData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

struct ContentData: Codable, Identifiable {
    let id: Int
    let created: String
    let url: URL
    let user: UserData
    let is_youtube: Bool
}
