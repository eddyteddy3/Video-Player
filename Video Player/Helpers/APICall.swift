//
//  APICall.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation

class ApiCall {
    
    func getData() {
        guard let url = URL(string: "https://iphonephotographyschool.com/test-api/videos") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let posts = try! JSONDecoder.init().decode(Video.self, from: data)
                
                print(posts)
            }
        }.resume()
        
    }
    
}
