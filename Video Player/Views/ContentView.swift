//
//  ContentView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 19/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var videos: [Post] = []
    
    var body: some View {
        List(videos) { video in
            Text("Hello, World!")
            
        }.onAppear {
            ApiCall.init().getData { (videos) in
                self.videos = videos
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
