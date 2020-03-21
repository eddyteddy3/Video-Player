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
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        //
        ApiCall.init().getData { (videos) in
            self.videos = videos
        }
        
    }
}


