//
//  DetailedVideoView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
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
        video = OfflineVideo(videoName: videoName, videoURL: videoURL)
        
        offlineVideo = HLSion(url: URL(string: videoURL)!, name: videoName)
        
        if video.isVideoExist() {
            print("Video Exist")
        } else {
            print("Video does not exist")
        }
        
        let player = AVPlayer(url: URL(string: videoURL)!)
        
        self.player = player
    }
    
    var body: some View {
        ZStack{
            PlayerView(player: player)
            //PlayerControls(player: player)
        }.onDisappear {
            self.player.pause()
        }
    }
}

struct PlayerControls: View  {
    @State var playerPaused = true
    let player: AVPlayer
    
    var body: some View {
        Button(action: {
            self.playerPaused.toggle()
            if self.playerPaused {
                self.player.pause()
            } else {
                self.player.play()
            }
        }) {
            Image(systemName: playerPaused ? "" : "play.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .accentColor(Color.black)
        }
    }
}

class OfflineVideo {
    var videoName: String
    var videoURL: String
    
    var offlineVideo: HLSion?
    
    init(videoName: String, videoURL: String) {
        self.videoName = videoName
        self.videoURL = videoURL
        
        self.offlineVideo = HLSion(url: URL(string: videoURL)!, name: videoName)
    }
    
    //function to check whether the video already exists in the app or not.
    //this funciton will help play the videos offline.
    func isVideoExist() -> Bool {
        if let videoPath = offlineVideo?.localUrl {
            if videoPath.absoluteString.contains(videoName) {
                print("already exits")
                return true
            } else {
                print("does not exist")
                return false
            }
        } else {
            print("Error")
            return false
        }
    }
}

struct DetailedVideoView: View {
    @State var videoName = ""
    @State var description = ""
    @State var isShowing = false
    @State var progress = 0.0
    @State var showAlert = false
    
    var imageURL = ""
    var videoURL = ""
    
    var downloader: HLSion?
    
    var body: some View {
        VStack {
            ZStack {
                if !isShowing {
                    ImageView(imageUrl: imageURL)
                        .frame(width: 400, height: 300, alignment: .center)
                        .cornerRadius(10)
                } else {
                    if isShowing {
                        PlayerContainerView(videoURL: self.videoURL, videoName: self.videoName)
                        .frame(width: 400, height: 300)
                        .cornerRadius(10)
                    }
                    
                }
                
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Image(systemName: isShowing ? "" : "play.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .accentColor(Color.black)
                }
            }
            
            Text(videoName)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.leading, 25)
                .padding(.trailing, 25)
            
            Text(description)
                .font(.body)
                .fontWeight(.medium)
                .padding(10)
            
            Spacer()
        }
        .onDisappear(perform: {
        })
            .navigationBarItems(trailing: Button(action: {
                self.downloadVideo(videoURL: self.videoURL, videoName: self.videoName)
            }, label: {
                HStack {
                    Text("Download Video")
                    Image(systemName: "square.and.arrow.down")
                    
                }
            }))
    }
    
    //function to download the video with the progress bar
    func downloadVideo(videoURL: String, videoName: String) {
        guard let url = URL(string: videoURL) else {return}
        //downloader = HLSion(url: url, name: videoName)
        
        if let videoDownloader = downloader {
            switch videoDownloader.state {
            case .notDownloaded:
                print("Downloading started")
                videoDownloader.download { percent in
                    print("Progress: \(percent)")
                    self.progress = percent/100
                }.finish { (path) in
                    print("Finished downloading: \(path)")
                    self.showAlert = true
                }
            case .downloading:
                break
            case .downloaded:
                self.showAlert = true
            }
        }
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
