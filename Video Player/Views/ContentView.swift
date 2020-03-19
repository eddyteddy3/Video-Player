//
//  ContentView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 19/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.videos) { video in
            VStack(alignment: .leading, spacing: 10) {
                Text(video.name).bold()
                Text("\(video.video_link)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
