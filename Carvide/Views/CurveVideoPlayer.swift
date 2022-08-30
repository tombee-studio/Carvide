//
//  VideoPlayer.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/18.
//

import SwiftUI
import AVKit

struct CurveVideoPlayer: View {
    let content: ContentData
    
    init(content:ContentData) {
        self.content = content
    }
    
    var body: some View {
        if content.is_youtube {
            if let videoId = content.video_id {
                YoutubePlayerView(video_id: videoId)
            }
        } else {
            VideoPlayer(player: AVPlayer(url: content.url))
        }
    }
}

struct CurveVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CurveVideoPlayer(content: ContentData.createContentData())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
