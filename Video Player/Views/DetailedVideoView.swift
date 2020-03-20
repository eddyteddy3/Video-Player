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
    var player: AVPlayer
    
    
    init(player: AVPlayer) {
        self.player = player
    }
    
    var body: some View {
        VStack {
            ZStack {
                WebImage(url: URL(string: imageURL)).resizable(capInsets: .init(), resizingMode: .stretch)
                    .resizable()
                    .frame(width: 400, height: 300)
                    .cornerRadius(10)
                
//                Button("") {
//                    self.isShowing.toggle()
//                }.overlay(Image(systemName: "play.circle").imageScale(.large)).sheet(isPresented: $isShowing) {
//                    PlayerView()
//                }
                
                Button(action: {
                    //self.isShowing.toggle()
                    PlayerView()
                }) {
                    Image(systemName: "play.circle")
                    //sheet(isPresented: $isShowing) {
                     //   PlayerView()
                    //}
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
    }
    
    func playVideo(url: String) {
        guard let url = URL(string: url) else {return}
        let player = AVPlayer(url: url)
        
        playerVC.player = player
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
