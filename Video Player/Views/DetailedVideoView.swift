//
//  DetailedVideoView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailedVideoView: View {
    @State var videoName = "This is video name for"
    @State var description = "This description is for a very very long text"
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: "https://i.picsum.photos/id/477/2000/2000.jpg")).resizable(capInsets: .init(), resizingMode: .stretch)
                //.resizable()
                .frame(width: 400, height: 300)
                .cornerRadius(10)
                .padding(.top)
            
            Text(videoName)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.leading, 40)
                .padding(.trailing, 40)
            
            Text(description)
                .font(.body)
                .fontWeight(.medium)
                .padding(.top)
                
            
            Spacer()
            
            
        }
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
