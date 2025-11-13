//
//  AnimeDetailView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import SwiftUI

struct AnimeDetailView: View {

    let anime: Anime

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DownloadableImageView(url: anime.images.url, type: .detail)
                VStack(alignment: .leading, spacing: 8) {
                    Text(anime.title)
                        .font(.title2)
                        .bold()
                    HStack(spacing: 12) {
                        if let year = anime.year {
                            Label("\(year)", systemImage: "calendar")
                        }
                        if let score = anime.score {
                            Label(String(format: "%.1f", score), systemImage: "star.fill")
                        }
                    }
                    .foregroundStyle(.secondary)
                    if let synopsis = anime.synopsis, !synopsis.isEmpty {
                        Text(synopsis)
                            .font(.body)
                            .foregroundStyle(.primary)
                    } else {
                        Text("No synopsis available.")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(anime.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NavigationStack {
        AnimeDetailView(anime: PreviewData.anime)
    }
}
