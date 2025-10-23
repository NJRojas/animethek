//
//  Images.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

struct Images: Decodable {
    let jpg: Jpeg
}

struct Jpeg: Decodable {

    let imageURL: URL
    let smallImageURL: URL?
    let largeImageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}
