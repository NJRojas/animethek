//
//  ServiceError.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

enum ServiceError: LocalizedError {
    case badURL
    case badStatus(Int, String)
    case decoding(String)
    case transport(URLError)
    
    var errorDescription: String? {
        switch self {
           case .badURL:
               return "Bad URL."
           case .badStatus(let code, let body):
               return "HTTP \(code). Body: \(body)"
           case .decoding(let msg):
               return "Decoding error: \(msg)"
           case .transport(let urlErr):
               return "Network error: \(urlErr.localizedDescription)"
        }
    }
}
