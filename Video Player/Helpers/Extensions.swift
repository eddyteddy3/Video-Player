//
//  Extensions.swift
//  Video Player
//
//  Created by Moazzam Tahir on 22/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import Foundation
import AVKit


extension ImageCache {
    private static var imageCache = ImageCache()
    
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}

extension VideoListCache {
    private static var listCache = VideoListCache()
    
    static func getListCache() -> VideoListCache {
        return listCache
    }
}
