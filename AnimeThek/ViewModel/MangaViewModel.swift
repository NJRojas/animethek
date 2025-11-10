//
//  MangaViewModel.swift
//  AnimeThek
//
//  Created by NJ Rojas on 10.11.25.
//

import Foundation

@MainActor
final class MangaViewModel: ObservableObject {

    @Published var movies: [Manga] = []

    @Published var isLoading = false

    @Published var errorMessage: String?

    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}
