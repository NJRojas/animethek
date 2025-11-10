//
//  Anime.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

struct Anime: Identifiable, Codable {
    let id: Int
    let title: String
    let images: Images
    let year: Int?
    let score: Double?
    let synopsis: String?

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case images
        case year
        case score
        case synopsis
    }
}

extension Anime: Equatable, Hashable {
    static func == (lhs: Anime, rhs: Anime) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
