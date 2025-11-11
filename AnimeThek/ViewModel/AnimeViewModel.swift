//
//  AnimeViewModel.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

@MainActor
final class AnimeViewModel: ObservableObject {
    
    @Published var movies: [Anime] = []
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?

    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    private let service = MovieService()

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            movies = try await service.fetchMovies().data
        } catch {
            errorMessage = (error as? ServiceError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }

    func loadMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        guard let url = Endpoint.anime.url else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }

        // you can also build string URL <baseURL>?<name>=<value>&<name>=<value>
        // e.g "<baseURL>?type=movie&limit=25"

        let resource =  Resource(
            url: url,
            method: .get([
                URLQueryItem(name: "type", value: "movie"),
                URLQueryItem(name: "limit", value: "25")
            ]),
            modelType: AnimeListResponse.self
           )
        do {
            movies = try await httpClient.load(resource).data
        } catch {
            errorMessage = (error as? NetworkError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }
}
