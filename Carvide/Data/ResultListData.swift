//
//  ResultListData.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/15.
//

import SwiftUI

struct ResultListData<T: Codable>: Codable {
    let pagination: PaginationData
    let models: [T]
}
