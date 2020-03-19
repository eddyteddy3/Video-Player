//
//  DataModel.swift
//  Video Player
//
//  Created by Moazzam Tahir on 20/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//
import SwiftUI

//this data model conforms to the API data model structure.
struct Post: Codable, Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var thumbnail: String
    var video_link: String
}


