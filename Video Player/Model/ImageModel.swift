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
    
    init(url: String) {
        self.imageURL = url
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: imageURL!) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage.init(data: data)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
