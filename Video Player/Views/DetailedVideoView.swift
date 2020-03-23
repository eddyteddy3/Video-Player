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
    var video: VideoURL
    
    init(videoURL: String, videoName: String) {
        video = VideoURL(videoName: videoName, videoURL: videoURL)
        
        let url = video.getVideoPath()
        
        let player = AVPlayer(url: url)
        
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

class VideoURL {
    var videoName: String
    var videoURL: String
    var fileManager = FileManager.default
    
    
    init(videoName: String, videoURL: String) {
        self.videoName = videoName
        self.videoURL = videoURL
        
        
    }
    
    
    func getVideoPath() -> URL {
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first as URL?
        let destination = documentPath?.appendingPathComponent("\(videoName).mp4")
        
        if let path = destination?.path {
            if fileManager.fileExists(atPath: path) {
                print("Already exists \(destination)")
                return destination!
            } else {
                return URL(string: videoURL)!
            }
        }
        return URL(string: videoURL)!
    }
}

struct DetailedVideoView: View {
    @State var videoName = ""
    @State var description = ""
    @State var isShowing = false
    
    var imageURL = ""
    var videoURL = ""
    
    var fileManager = FileManager.default
    
    var downloader: HLSion?
    
    var body: some View {
        VStack {
            ZStack {
                if !isShowing {
                    ImageView(imageUrl: imageURL)
                        .frame(width: 400, height: 300, alignment: .center)
                        .cornerRadius(10)
                } else {
                    /*PlayerView(player: player)
                     .frame(width: 400, height: 300)
                     .cornerRadius(10)*/
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
                self.downloadVideo(videoURL: self.videoURL)
            }, label: {
                HStack {
                    Text("Download Video")
                    Image(systemName: "square.and.arrow.down")
                    
                }
            }))
    }
    
    //function to check whether the video already exists in the app or not.
    //this funciton will help play the videos offline.
    func isVideoExist(videoName: String) -> Bool {
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first as URL?
        let destination = documentPath?.appendingPathComponent("\(videoName).mp4")
        
        if let path = destination?.path {
            if fileManager.fileExists(atPath: path) {
                print("Already exists")
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func downloadVideo(videoURL: String) {
        guard let url = URL(string: videoURL) else {return}
        
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first as URL?
        let destination = documentPath?.appendingPathComponent("\(videoName).mp4")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.downloadTask(with: URLRequest(url: url)) { (tempURL, _, error) in
            if let tempUrl = tempURL, error == nil {
                do {
                    try FileManager.default.copyItem(at: tempUrl, to: destination!)
                    print("Video Downloaded at \(destination!.absoluteString)")
                } catch let err {
                    print("Error: \(err.localizedDescription)")
                }
            } else {
                print("ERROR downloading: \(error?.localizedDescription ?? "string error")")
            }
        }
        task.resume()
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
