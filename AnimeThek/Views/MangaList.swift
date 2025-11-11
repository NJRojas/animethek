//
//  MangaList.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import SwiftUI

struct MangaList: View {
    
    @StateObject private var model = MangaViewModel(httpClient: HTTPClient())

    var body: some View {
        Group {
            if model.isLoading && model.media.isEmpty {
                ProgressView("Loading media…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let err = model.errorMessage, model.media.isEmpty {
                VStack(spacing: 12) {
                    Text("Couldn’t load media")
                        .font(.headline)
                    Text(err).font(.callout).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    Button("Retry") { Task { await model.loadMedia() } }
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(model.media) { media in
                    NavigationLink(value: media) {
                        MangaRow(manga: media)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await model.loadMedia()
                }
            }
        }
        .navigationTitle("Manga")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Manga.self) { manga in
            MangaDetailView(manga: manga)
        }
        .task { await model.loadMedia() }
    }
}

#Preview {
    NavigationStack {
        MangaList()
    }
}
