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
            .navigationBarItems(trailing: Button("Load Items"){
                for names in self.store.videos {
                    let post = self.store.loadListFromCache(videoName: names.name)
                     print(post)
                }
            })
        }
    }
    
    func fillArray() {
        for names in store.videos {
            store.loadListFromCache(videoName: names.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class VideoListCache {
    var cache = NSCache<NSString, AnyObject>()
    
    func get(forKey: String) -> Post? {
        return cache.object(forKey: NSString(string: forKey)) as? Post
    }
    
    func set(forKey: String, post: Post) {
        cache.setObject(post as AnyObject, forKey: NSString(string: forKey))
    }
}
