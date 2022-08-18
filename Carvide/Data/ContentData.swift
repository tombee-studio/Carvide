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
    let video_id: String?
    
    static func createContentData() -> ContentData {
        let content = ContentData(
            id: 0,
            created: "",
            url: URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4")!,
            user: UserData.createGuestUserData(),
            is_youtube: false,
            video_id: nil
        )
        return content
    }
    
    static func createYoutubeData() -> ContentData {
        let content = ContentData(
            id: 0,
            created: "",
            url: URL(string: "https://www.youtube.com/watch?v=Yw5HTeT_dis")!,
            user: UserData.createGuestUserData(),
            is_youtube: true,
            video_id: "Yw5HTeT_dis"
        )
        return content
    }
}
