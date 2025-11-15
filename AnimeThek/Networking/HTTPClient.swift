//
//  HTTPClient.swift
//  AnimeThek
//
//  Created by NJ Rojas on 23.10.25.
//

import Foundation

// Scales better
// one generic loader,
// clear request modeling,
// and testability via injectable session.
struct HTTPClient {

    private let session: URLSession

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "User-Agent": "AnimeThek/1.0 (iOS)"
        ]
        self.session = URLSession(configuration: configuration)
    }

    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {

        var request = URLRequest(url: resource.url, timeoutInterval: 30)
        request.cachePolicy = .reloadIgnoringLocalCacheData

        // Set HTTP method and body if needed
        switch resource.method {
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                    throw NetworkError.badRequest
                }
                request.url = url

            case .post(let data), .put(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data

            case .delete:
                request.httpMethod = resource.method.name
        }

        // Set custom headers
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            // MARK: - Handle non-success HTTP codes
            guard (200...299).contains(httpResponse.statusCode) else {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    throw NetworkError.errorResponse(errorResponse)
                }
                let snippet = String(data: data.prefix(1024), encoding: .utf8) ?? "<non-utf8>"
                throw NetworkError.errorResponse(ErrorResponse(message: "HTTP \(httpResponse.statusCode): \(snippet)"))
            }

            // MARK: - Successful response: try decoding
            do {
                return try JSONDecoder().decode(resource.modelType, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let urlError as URLError {
            // MARK: - Network transport errors
            switch urlError.code {
                case .notConnectedToInternet:
                    throw NetworkError.errorResponse(ErrorResponse(message: "No internet connection"))
                case .timedOut:
                    throw NetworkError.errorResponse(ErrorResponse(message: "Request timed out"))
                default:
                    throw NetworkError.errorResponse(ErrorResponse(message: "Transport error: \(urlError.localizedDescription)"))
            }
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

extension HTTPClient {

    // For Test purpose (dependency injection)
    init(session: URLSession) {
        self.session = session
    }

    static var development: HTTPClient {
        HTTPClient()
    }
}
