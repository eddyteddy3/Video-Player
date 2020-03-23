//
//  ImageModel.swift
//  Video Player
//
//  Created by Moazzam Tahir on 21/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    var imageURL: String?
    var imageCache = ImageCache.getImageCache()
    
    init(url: String) {
        self.imageURL = url
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            print("loading from cache")
            return
        }
        
        guard let url = URL(string: imageURL!) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                guard let image = UIImage.init(data: data) else {return}
                
                print("loading from url")
                DispatchQueue.main.async {
                    self.imageCache.set(forkey: self.imageURL!, image: image)
                    self.image = image
                }
            }
        }.resume()
    }
    
    func loadImageFromCache() -> Bool {
        guard let url = imageURL else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: url) else {
            return false
        }
        
        image = cacheImage
        return true
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forkey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forkey))
    }
}


