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
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        
    }
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
    
}

class PlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    var videoURL = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let url = URL(string: videoURL) else {return}
        
        let player = AVPlayer(url: url)
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
    var imageURL = ""
    
    
    var body: some View {
        VStack {
            ZStack {
                WebImage(url: URL(string: imageURL)).resizable(capInsets: .init(), resizingMode: .stretch)
                    .resizable()
                    .frame(width: 400, height: 300)
                    .cornerRadius(10)
                
                Button("") {
                    
                }.overlay(Image(systemName: "play.circle").imageScale(.large))
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
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
