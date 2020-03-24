//
//  ContentView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 19/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import UIKit
import SwiftUIPullToRefresh

struct ContentView: View {
    @ObservedObject var store = DataStore()
    var cache = ImageCache.getImageCache()
    var namesArray: [Post] = []
    
    var body: some View {
        //NavigationView {
        RefreshableNavigationView(title: "Videos", action: {
            self.store.loadMore()
        }) {
            /*List(self.store.videos) { video in
             NavigationLink(destination: DetailedVideoView(videoName: video.name, description: video.description, imageURL: video.thumbnail, videoURL: video.video_link)) {
             HStack(spacing: 5) {
             ImageView(imageUrl: video.thumbnail)
             .frame(width: 50, height: 50)
             .cornerRadius(5)
             Text(video.name)
             }
             }
             }*/
            ForEach(self.store.videos) { (video) in
                NavigationLink(destination: DetailedVideoView(videoName: video.name, description: video.description, imageURL: video.thumbnail, videoURL: video.video_link)) {
                    HStack(spacing: 5) {
                        ImageView(imageUrl: video.thumbnail)
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        Text(video.name)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
