//
//  Resource.swift
//  AnimeThek
//
//  Created by NJ Rojas on 23.10.25.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
    var modelType: T.Type
}
