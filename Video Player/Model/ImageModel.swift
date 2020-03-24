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
    @Published var image: UIImage? //will allow to get the image and pass it to observedObject
    
    var imageURL: String?
    var imageCache = ImageCache.getImageCache()
    
    init(url: String) {
        self.imageURL = url
        loadImage()
    }
    
    func loadImage() {
        //if there is picture in cache then it will be loaded from that
        if loadImageFromCache() {
            print("loading from cache")
            return
        }
        
        //else it will be loaded from url
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
    
    //func to load from cache
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




