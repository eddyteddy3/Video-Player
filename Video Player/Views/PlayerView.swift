//
//  PlayerView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 24/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlayerView>) -> AVPlayerViewController {
        
        let playerVC = AVPlayerViewController()
        let player1 = player
        
        playerVC.player = player1
        player1.play()
        
        return playerVC
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<PlayerView>) {
        
    }
}

struct PlayerContainerView: View {
    @State var isShowing = true
    var player: AVPlayer
    var video: OfflineVideo
    
    var offlineVideo: HLSion?
    
    init(videoURL: String, videoName: String) {
        offlineVideo = HLSion(url: URL(string: videoURL)!, name: videoName)
        video = OfflineVideo(videoName: videoName, offlineVideo: offlineVideo!)
        
        if video.isVideoExist() {
            print("Video Exist")
            
            let asset = AVURLAsset(url: (offlineVideo?.localUrl)!)
            let playerItem = AVPlayerItem(asset: asset)
            self.player = AVPlayer(playerItem: playerItem)
        } else {
            print("Video does not exist")
            
            let player = AVPlayer(url: URL(string: videoURL)!)
            self.player = player
        }
    }
    
    var body: some View {
        ZStack{
            PlayerView(player: player)
        }.onDisappear {
            self.player.pause()
        }
    }
}

class OfflineVideo {
    var videoName: String
    
    var offlineVideo: HLSion?
    
    init(videoName: String, offlineVideo: HLSion) {
        self.videoName = videoName
        self.offlineVideo = offlineVideo
    }
    
    //function to check whether the video already exists in the app or not.
    //this funciton will help play the videos offline.
    func isVideoExist() -> Bool {
        if let _ = offlineVideo?.localUrl {
            print("Exist")
            return true
        } else {
            print("not exist")
            return false
        }
    }
}
