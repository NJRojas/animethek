//
//  AnimeRow.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import SwiftUI

struct AnimeRow: View {

    let anime: Anime

    var body: some View {
        HStack(spacing: 12) {
            DownloadableImageView(
                url: anime.images.jpg.imageURL,
                type: .thumbnail
            )
            VStack(alignment: .leading, spacing: 4) {
                Text(anime.title)
                    .font(.headline)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    if let year = anime.year {
                        Label("\(year)", systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let score = anime.score {
                        Label(String(format: "%.1f", score), systemImage: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    AnimeRow(anime: PreviewData.anime)
}
