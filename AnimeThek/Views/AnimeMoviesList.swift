//
//  AnimeMoviesList.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import SwiftUI

struct AnimeMoviesList: View {

    @StateObject private var model = AnimeViewModel(httpClient: HTTPClient())

    var body: some View {
        Group {
            if model.isLoading && model.movies.isEmpty {
                ProgressView("Loading movies…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let err = model.errorMessage, model.movies.isEmpty {
                VStack(spacing: 12) {
                    Text("Couldn’t load movies")
                        .font(.headline)
                    Text(err).font(.callout).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    Button("Retry") { Task { await model.loadMovies() } }
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(model.movies) { anime in
                    NavigationLink(value: anime) {
                        AnimeRow(anime: anime)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await model.loadMovies()
                }
            }
        }
        .navigationTitle("Anime Movies")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Anime.self) { anime in
            AnimeDetailView(anime: anime)
        }
        .task { await model.loadMovies() }
    }
}

#Preview {
    AnimeMoviesList()
}
