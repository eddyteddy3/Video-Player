//
//  LoadImage.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//
import Foundation
import UIKit
//import Combine

class LoadImage {
    var image = UIImage()
    
    func getImage(imageLink url: String, completionHandler: @escaping (UIImage) -> ()) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            if let data = data {
                guard let image = UIImage(data: data) else {return}
                print("DATA: \(image.size)")
                
                //self.image = image
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }
            
        }.resume()
    }
}

