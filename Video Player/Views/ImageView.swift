//
//  ImageView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 21/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var image: ImageLoader
    var height: CGFloat
    var width: CGFloat
    static var placeholderImage = UIImage.init(systemName: "exclamationmark.icloud.fill")
    
    init(imageUrl: String, height: CGFloat, width: CGFloat) {
        image = ImageLoader(url: imageUrl)
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Image(uiImage: image.image ?? ImageView.placeholderImage!)
        .resizable()
        .scaledToFill()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "", height: 0, width: 0)
    }
}
