//
//  PaginationData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import Foundation

struct PaginationData: Codable {
    let previous_page: Int?
    let next_page: Int?
    let start_index: Int
    let end_index: Int
    let total_entries: Int
    let total_pages: Int
    let page: Int
}
