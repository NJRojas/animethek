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
            let response = try await service.fetchMovies()
            movies = response.data
        } catch {
            errorMessage = (error as? AnimeServiceError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }

    func loadMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: Endpoint.animeMoviesList) else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }

        let resource = Resource(url: url, modelType: AnimeListResponse.self)
        do {
            let response = try await httpClient.load(resource)
            movies = response.data
        } catch {
            errorMessage = (error as? NetworkError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }
}
