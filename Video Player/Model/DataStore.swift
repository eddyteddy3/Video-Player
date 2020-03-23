//
//  DataStore.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import Combine

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
}


class DataModel: ObservableObject {
    @Published var posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
    
    func addElements() {
        //posts.append(Post(name: <#T##String#>, description: <#T##String#>, thumbnail: <#T##String#>, video_link: <#T##String#>))
    }
}
