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
    //@ObservedObjecasdasdt var image1: ImageStore
    
    var body: some View {
        NavigationView {
            List(store.videos) { video in
                NavigationLink(destination: DetailedVideoView(videoName: video.name, description: video.description, imageURL: video.thumbnail)) {
                    HStack(spacing: 5) {
                        WebImage(url: URL(string: video.thumbnail))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        //Image(uiImage: self.getVideo(url: video.thumbnail))
                          //  .resizable()
                            //.frame(width: 20, height: 20)
                        
                        
                        Text(video.name).bold()
                    }
                }
            }
        .navigationBarTitle("Videos")
        }
    }
    
//    func getVideo(url: String) -> UIImage {
//        let image1 = LoadImage()
//        image1.getImage(imageLink: url) { (image) in
//            image1.image = image
//            print(image1.image.size)
//        }
//        print("Out of completionHandler: \(image1.image.size)")
//        return image1.image
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
