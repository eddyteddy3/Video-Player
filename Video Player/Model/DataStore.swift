//
//  DataStore.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import Combine

//class to load the list and save in a array and return back to ContentView
class DataStore: ObservableObject {
    @Published var videos: [Post] = []
    
    var videoName: String?
    var postCache = VideoListCache.getListCache()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        ApiCall.init().getData { (videos) in
            for video in videos {
                print("Video \(video.name)")
                DispatchQueue.main.async {
                    self.postCache.set(forKey: video.name
                    , post: video)
                    self.videos.append(video)
                }
            }
        }
    }
    
    func loadListFromCache(videoName: String) -> Post? {
        
        let post = (postCache.get(forKey: videoName))
        return post
    }
    
    //function to load more objects upon refreshing
    func loadMore() {
        var couter = 1
        
        ApiCall.init().getData { (videos) in
            print(videos.count)
            print(self.videos.count)
            for video in videos {
                couter = 1
                for post in self.videos {
                    if post.name != video.name && couter > 14 { //condition to not to let add duplicate items
                        print("not Found")
                        print(post)
                        return
                    } else {
                        print("found \(couter)")
                        couter += 1
                    }
                }
            }
        }
    }
}
