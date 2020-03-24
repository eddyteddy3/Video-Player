//
//  Caching.swift
//  Video Player
//
//  Created by Moazzam Tahir on 24/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forkey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forkey))
    }
}

class VideoListCache {
    var cache = NSCache<NSString, AnyObject>()
    
    func get(forKey: String) -> Post? {
        return cache.object(forKey: NSString(string: forKey)) as? Post
    }
    
    func set(forKey: String, post: Post) {
        cache.setObject(post as AnyObject, forKey: NSString(string: forKey))
    }
}
