//
//  YoutubePlayerView.swift
//  Carvide
//
//  Created by Tomoya Bansho on 2022/08/18.
//

import SwiftUI
import YoutubeKit
import CoreMedia

struct YoutubePlayerView: UIViewRepresentable {
    let video_id: String
    let player: YTSwiftyPlayer
    
    init(video_id: String) {
        self.video_id = video_id
        self.player = YTSwiftyPlayer()
    }
    
    typealias UIViewType = YTSwiftyPlayer
    
    func makeUIView(context: Context) -> YTSwiftyPlayer {
        player.autoplay = true
        return player
    }
    
    func updateUIView(_ uiView: YTSwiftyPlayer, context: Context) {
        uiView.setPlayerParameters([
            .playsInline(true),
            .videoID(self.video_id),
        ])
        guard let playerURL = Bundle.main.url(forResource: "player", withExtension: "html") else { fatalError("player.htmlが見つからない") }
        guard let htmlString = try? String(contentsOf: playerURL, encoding: .utf8) else { fatalError("player.htmlを開けない") }
        uiView.loadPlayerHTML(htmlString)
    }
    
    public func getDuration() -> Double? {
        return player.duration
    }
}

struct YoutubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubePlayerView(video_id: "Yw5HTeT_dis")
    }
}
