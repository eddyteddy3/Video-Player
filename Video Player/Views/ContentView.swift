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

struct ImageCustom {
    var imageURL: String
    
    func loadImage() {
       //LoadImage().getImage(imageLink: imageURL)
    }
}

struct ContentView: View {
    @ObservedObject var store = DataStore()
    //@ObservedObject var image1: ImageStore
    
    var body: some View {
        List(store.videos) { video in
        //image1 = ImageStore(url: video.thumbnail)
        
             HStack(spacing: 10) {
                WebImage(url: URL(string: video.thumbnail))
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(video.name).bold()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
