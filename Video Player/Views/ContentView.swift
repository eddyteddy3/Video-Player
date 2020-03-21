//
//  ContentView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 19/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var store = DataStore()
    
    var body: some View {
        NavigationView {
            List(store.videos) { video in
                NavigationLink(destination: DetailedVideoView(videoName: video.name, description: video.description, imageURL: video.thumbnail, videoURL: video.video_link)) {
                    HStack(spacing: 5) {
                        ImageView(imageUrl: video.thumbnail, height: 40, width: 40)
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                        Text(video.name).bold()
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
