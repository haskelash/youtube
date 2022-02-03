//
//  YoutubeCell.swift
//  Youtube
//
//  Created by Haskel Ash on 2/3/22.
//

import UIKit
import AVKit

class YoutubeCell: UITableViewCell {

  private var playerLayer: AVPlayerLayer!

  func update(videoId: String) {
    let url = URL(string: "https://youtube.com/watch?v=\(videoId)")!
    let asset = AVURLAsset(url: url)
    let playerItem = AVPlayerItem(asset: asset)
    let player = AVPlayer(playerItem: playerItem)

    if playerLayer == nil {
      playerLayer = AVPlayerLayer(player: player)
      playerLayer.videoGravity = .resizeAspectFill
    } else {
      playerLayer.player = player
    }

    playerLayer.frame = layer.bounds
    player.play()
  }
}
