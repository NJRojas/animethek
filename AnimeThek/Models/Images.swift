//
//  Images.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

struct Images: Codable {
    let jpg: Jpeg

    var url: URL {
        jpg.largeImageURL ?? jpg.imageURL
    }
}

struct Jpeg: Codable {

    let imageURL: URL
    let smallImageURL: URL?
    let largeImageURL: URL?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}
