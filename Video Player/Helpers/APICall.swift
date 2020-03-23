//
//  APICall.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation

class ApiCall {
    
    var postCache = VideoListCache.getListCache()
    
    func getData(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://iphonephotographyschool.com/test-api/videos") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let videos = try! JSONDecoder.init().decode(Video.self, from: data)
                
                DispatchQueue.main.async {
                    completion(videos.self.videos)
                }
                
            }
        }.resume()
        
    }
    
}
