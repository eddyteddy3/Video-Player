//
//  DetailedVideoView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI
import AVKit

struct DetailedVideoView: View {
    @State var videoName = ""
    @State var description = ""
    @State var isShowing = false
    @State var progress: CGFloat = 0.0
    @State var inProgress = false
    @State var isDownloaded = false
    
    var imageURL = ""
    var videoURL = ""
    
    var body: some View {
        let downloader = HLSion(url: URL(string: videoURL)!, name: videoName)
        
        return VStack {
            ZStack {
                if !isShowing {
                    ImageView(imageUrl: imageURL)
                        .frame(width: 400, height: 300, alignment: .center)
                        .cornerRadius(10)
                } else {
                    if isShowing {
                        PlayerContainerView(videoURL: self.videoURL, videoName: self.videoName)
                            .frame(width: 400, height: 300)
                            .cornerRadius(10)
                    }
                }
                
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Image(systemName: isShowing ? "" : "play.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .accentColor(Color.black)
                }
            }
            
            Text(videoName)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.leading, 25)
                .padding(.trailing, 25)
            
            Text(description)
                .font(.body)
                .fontWeight(.medium)
                .padding(10)
            
            Spacer()
        }
        .onDisappear(perform: {
        })
            .navigationBarItems(trailing: Button(action: {
                self.downloadVideo(downloader: downloader)
            }, label: {
                HStack {
                    if !inProgress {
                        Text("Download Video")
                        Image(systemName: "square.and.arrow.down")
                    } else if inProgress && isDownloaded {
                        Text("Downloaded!")
                    } else if inProgress == true {
                        //ProgressBar(value: $progress)
                        //  .frame(width: 100, height: 20, alignment: .trailing)
                        Button("Cancel") {
                            downloader.download().cancelDownload()
                            self.inProgress = false
                            self.progress = 0.0
                        }
                        
                        ProgressView(progress: $progress)
                    }
                }
            }))
    }
    
    //function to download the video with the progress bar
    func downloadVideo(downloader: HLSion) {
        switch downloader.state {
        case .notDownloaded:
            print("Downloading started")
            downloader.download { percent in
                print("Progress: \(percent * 10)")
                self.inProgress = true
                self.progress = CGFloat(percent * 10)
            }.finish { (path) in
                print("Finished downloading: \(path)")
                self.isDownloaded = true
                self.progress = 0.0
            }
        case .downloading:
            break
        case .downloaded:
            self.inProgress = true
            self.isDownloaded = true
            self.progress = 0.0
        }
    }
}

struct DetailedVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedVideoView()
    }
}
