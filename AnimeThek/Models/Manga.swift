//
//  Manga.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import Foundation

enum PublishingStatus: String, Identifiable, Hashable, Codable {
    case publishing
    case onHiatus
    case finished
    
    var id: Self { self }
    
    enum CodingKeys: String, CodingKey {
        case publishing = "Publishing"
        case onHiatus = "On Hiatus"
        case finished = "Finished"
    }
}

struct Manga: Identifiable, Codable {
    let id: Int
    let title: String
    let images: Images
    let score: Double?
    let rank: Int?
    let status: String?
    let chapters: Int?
    let volumes: Int?
    let popularity: Int?
    let synopsis: String?

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case images
        case score
        case rank
        case status
        case chapters
        case volumes
        case popularity
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
