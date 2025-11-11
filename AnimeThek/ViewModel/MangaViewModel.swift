//
//  MangaViewModel.swift
//  AnimeThek
//
//  Created by NJ Rojas on 10.11.25.
//

import Foundation

@MainActor
final class MangaViewModel: ObservableObject {

    @Published var media: [Manga] = []

    @Published var isLoading = false

    @Published var errorMessage: String?

    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadMedia() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        guard let url = Endpoint.manga.url else {
            errorMessage = NetworkError.badURL.localizedDescription
            return
        }
        let resource =  Resource(
            url: url,
            method: .get([URLQueryItem(name: "limit", value: "25")]),
            modelType: MangaListResponse.self
           )
        do {
            media = try await httpClient.load(resource).data
        } catch {
            errorMessage = (error as? NetworkError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }
}
