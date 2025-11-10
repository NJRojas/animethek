//
//  Manga.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import Foundation

struct Manga: Identifiable, Codable {
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

extension Manga: Equatable, Hashable {
    static func == (lhs: Manga, rhs: Manga) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
