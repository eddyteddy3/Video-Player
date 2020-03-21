//
//  DetailedVideoView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
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

struct DetailedVideoView: View {
    @State var videoName = "This is video name for"
    @State var description = "This description is for a very very long text"
    @State var isShowing = false
    
    var imageURL = ""
    var videoURL = ""
    
    var body: some View {
        let player = AVPlayer(url: URL(string: videoURL)!)
        
        return VStack {
            ZStack {
                
                if !isShowing {
                    WebImage(url: URL(string: imageURL)).resizable(capInsets: .init(), resizingMode: .stretch)
                        .resizable()
                        .frame(width: 400, height: 300)
                        .cornerRadius(10)
                        .onAppear() {
                            player.pause()
                    }
                } else {
                    PlayerView(player: player)
                        .frame(width: 400, height: 300)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.isShowing.toggle()
                    player.play()
                }) {
                    Image(systemName: isShowing ? "" : "play.circle").accentColor(Color.black)
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
            //download video
        }, label: {
            HStack {
                Text("Download Video")
                Image(systemName: "square.and.arrow.down")
            }
        }))
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
