//
//  ImageView.swift
//  Video Player
//
//  Created by Moazzam Tahir on 21/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import SwiftUI

//a view to handle image loading from the web or from cache
struct ImageView: View {
    @ObservedObject var image: ImageLoader
    static var placeholderImage = UIImage.init(systemName: "exclamationmark.icloud.fill") //this is default image if the image is not loaded
    
    init(imageUrl: String) {
        image = ImageLoader(url: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: image.image ?? ImageView.placeholderImage!)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "")
    }
}



