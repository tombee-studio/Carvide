//
//  VideoPlayer.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/18.
//

import SwiftUI
import AVKit
import YoutubeKit

struct CurveVideoPlayer: View {
    enum CurveVideoPlayerError: Error {
        case FAILED_LOAD_VIDEO_ERROR
    }
    
    let content: ContentData
    let playerItem: AVPlayerItem
    let youtubePlayer: YoutubePlayerView
    lazy var observation: NSKeyValueObservation? = nil
    
    init(content:ContentData, _ success: @escaping (AVPlayerItem) -> Void) {
        self.content = content
        playerItem = AVPlayerItem(url: content.url)
        youtubePlayer = YoutubePlayerView(video_id: content.video_id ?? "Yw5HTeT_dis")
        observation = playerItem.observe(\.status) {item, change in
            switch item.status {
            case .readyToPlay:
                success(item)
            default: break
            }
        }
    }
    
    var body: some View {
        if content.is_youtube {
            if let videoId = content.video_id {
                youtubePlayer
            }
        } else {
            VideoPlayer(player: AVPlayer(playerItem: playerItem))
        }
    }
    
    public func getDuration() -> Double {
        if content.is_youtube {
            return youtubePlayer.getDuration()!
        } else {
            return playerItem.duration.seconds
        }
    }
}

struct CurveVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CurveVideoPlayer(content: ContentData.createContentData()) { item in
            print(item)
        }
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
