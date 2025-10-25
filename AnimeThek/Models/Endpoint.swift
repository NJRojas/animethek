//
//  Endpoint.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import Foundation

let baseURLString = "https://api.jikan.moe/v4"

enum Endpoint: String {
    case anime
    case manga
    case genres
    case characters
    case magazines
    case people
    case producers
    
    var url: URL? {
        URL(string: "\(baseURLString)/\(self)")
    }
}
