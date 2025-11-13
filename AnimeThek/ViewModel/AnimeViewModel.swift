//
//  AnimeViewModel.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

@MainActor
final class AnimeViewModel: ObservableObject {

    @Published var animeList: [Anime] = []

    @Published var isLoading = false

    @Published var errorMessage: String?

    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func fetchAnime() async {
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
            animeList = try await httpClient.load(resource).data
        } catch {
            errorMessage = (error as? NetworkError)
                .map { "\($0)" } ?? error.localizedDescription
        }
        isLoading = false
    }
}
