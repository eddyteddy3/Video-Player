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

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
}

class PlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        player.play()
        
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = bounds
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
                }
                
                Button(action: {
                    self.isShowing.toggle()
                    
                }) {
                    Image(systemName: "play.circle")
                }
            }
            //.padding(.top)
            
            
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
        
        .navigationBarItems(trailing: Button(action: {
            
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
