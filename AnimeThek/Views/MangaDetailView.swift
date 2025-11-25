//
//  MangaDetailView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 11.11.25.
//

import SwiftUI

struct MangaDetailView: View {

    let manga: Manga
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DownloadableImageView(url: manga.images.url, type: .detail)
                VStack(alignment: .leading, spacing: 8) {
                    Text(manga.title)
                        .font(.title2)
                        .bold()
                    HStack(spacing: 12) {
                        if let rank = manga.rank {
                            Text("\(rank)")
                        }
                        if let score = manga.score {
                            Text(String(format: "⭐️  %.1f", score))
                                .foregroundStyle(.blue)
                        }
                    }
                    .foregroundStyle(.secondary)
                    if let synopsis = manga.synopsis, !synopsis.isEmpty {
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
        .navigationTitle(manga.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// renders the view using only the minimum size needed to fit its content
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        MangaDetailView(manga: PreviewData.manga)
    }
}
