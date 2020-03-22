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
    let player: AVPlayer
    
    init(player: AVPlayer) {
        self.player = player
    }
    
    var body: some View {
        PlayerView(player: player)
    }
}



struct DetailedVideoView: View {
    @State var videoName = ""
    @State var description = ""
    @State var isShowing = false
    
    var imageURL = ""
    var videoURL = ""
    
    var fileManager = FileManager.default
    
    var body: some View {
        let player = AVPlayer(url: URL(string: videoURL)!)
        
        return VStack {
            ZStack {
                if !isShowing {
                    ImageView(imageUrl: imageURL)
                        .frame(width: 400, height: 300, alignment: .center)
                        .cornerRadius(10)
                } else {
                    PlayerView(player: player)
                        .frame(width: 400, height: 300)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.isShowing.toggle()
                    player.play()
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
            player.pause()
        })
            .navigationBarItems(trailing: Button(action: {
                self.PlayVideo(videoUrl: self.videoURL, videoName: self.videoName)
            }, label: {
                HStack {
                    Text("Download Video")
                    Image(systemName: "square.and.arrow.down")
                }
            }))
    }
    
    func PlayVideo(videoUrl: String, videoName: String) {
        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first as URL?
        let destination = documentPath?.appendingPathComponent("\(videoName).mp4")
    
        if let path = destination?.path {
            if fileManager.fileExists(atPath: path) {
                print("Already exists")
            } else {
                downloadVideo(videoURL: videoURL, destination: destination!)
            }
        }
        
        
    }
    
    func downloadVideo(videoURL: String, destination: URL) {
        guard let url = URL(string: videoURL) else {return}
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.downloadTask(with: URLRequest(url: url)) { (tempURL, _, error) in
            if let tempUrl = tempURL, error == nil {
                do {
                    try FileManager.default.copyItem(at: tempUrl, to: destination)
                    print("Video Downloaded at \(destination.absoluteString)")
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
