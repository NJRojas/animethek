//
//  NetworkError.swift
//  AnimeThek
//
//  Created by NJ Rojas on 23.10.25.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse)
    
    var errorDescription: String? {
        switch self {
            case .badURL:
                return NSLocalizedString("Bad URL (404): Unable to perform, the server could not find the requested resourceat the given URL, invalid URL.", comment: "badURLError")
            case .badRequest:
                return NSLocalizedString("Bad Request (400): Unable to perform the request.", comment: "badRequestError")
            case .decodingError(let error):
                return NSLocalizedString("Unable to decode successfully. \(error)", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response.", comment: "invalidResponse")
            case .errorResponse(let errorResponse):
                return NSLocalizedString("Error \(errorResponse.message ?? "")", comment: "Error Response")
        }
    }
}

struct ErrorResponse: Codable {
    let message: String?
}
