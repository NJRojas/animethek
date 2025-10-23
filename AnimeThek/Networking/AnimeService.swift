//
//  AnimeService.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

enum AnimeServiceError: LocalizedError {
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

struct MovieService {

    private let base = "https://api.jikan.moe/v4/anime?type=movie&limit=25"

    func fetchMovies() async throws -> AnimeListResponse {
        guard let url = URL(string: base) else { throw AnimeServiceError.badURL }

        var request = URLRequest(url: url, timeoutInterval: 30)
        request.setValue("AnimeMoviesDemo/1.0 (iOS)", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            if !(200...299).contains(http.statusCode) {
                let snippet = String(data: data.prefix(1024), encoding: .utf8) ?? "<non-utf8>"
                throw AnimeServiceError.badStatus(http.statusCode, snippet)
            }

            do {
                return try JSONDecoder().decode(AnimeListResponse.self, from: data)
            } catch {
                // Show a helpful decoding message (where it failed)
                throw AnimeServiceError.decoding(String(describing: error))
            }
        } catch let urlErr as URLError {
            throw AnimeServiceError.transport(urlErr)
        } catch {
            throw error
        }
    }

    func checkInternet() async -> String {
        let testURL = URL(string: "https://www.apple.com/library/test/success.html")!
        do {
            let (_, resp) = try await URLSession.shared.data(from: testURL)
            if let http = resp as? HTTPURLResponse { return "Internet OK (HTTP \(http.statusCode))" }
            return "Internet response not HTTP."
        } catch {
            return "Internet check failed: \(error.localizedDescription)"
        }
    }
}
