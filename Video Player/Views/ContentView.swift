//
//  ContentView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 19/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var store = DataStore()
    var cache = ImageCache.getImageCache()
    
    var body: some View {
        NavigationView {
            List(store.videos) { video in
                NavigationLink(destination: DetailedVideoView(videoName: video.name, description: video.description, imageURL: video.thumbnail, videoURL: video.video_link)) {
                    HStack(spacing: 5) {
                        ImageView(imageUrl: video.thumbnail)
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        Text(video.name)
                    }
                }
            }
        .navigationBarTitle("Videos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class VideoListCache {
    var cache = NSCache<NSString, NSString>()
    
    func get(forKey: String) -> String? {
        return cache.object(forKey: NSString(string: forKey)) as String?
    }
    
    func set(forKey: String, imageUrl: String) {
        cache.setObject(NSString(string: imageUrl), forKey: NSString(string: forKey))
    }
}
