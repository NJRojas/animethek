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

    private let service = MovieService()

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            movies = try await service.fetchMovies()
        } catch {
            errorMessage = (error as? AnimeServiceError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }
}
