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
    static var placeholderImage = UIImage.init(systemName: "exclamationmark.icloud.fill")
    
    init(imageUrl: String) {
        image = ImageLoader(url: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: image.image ?? ImageView.placeholderImage!)
        .resizable()
        .scaledToFit()
        .frame(width: 50, height: 50)
        .cornerRadius(5)
        .padding(5)
    }
    
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "")
    }
}
