//
//  MangaRow.swift
//  AnimeThek
//
//  Created by NJ Rojas on 10.11.25.
//

import SwiftUI

struct MangaRow: View {
    
    let manga: Manga

    var body: some View {
        HStack(spacing: 12) {
            DownloadableImageView(
                url: manga.images.jpg.imageURL,
                type: .thumbnail,
            )
            VStack(alignment: .leading, spacing: 4) {
                Text(manga.title)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.top, 10)
                
                HStack(spacing: 5) {
                    if let score = manga.score {
                        Text(String(format: "⭐️ %.1f", score))
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    if let rank = manga.rank {
                        TagView(value: rank, label: "Ranked", prefix: "#", color: .blue)
                    }
                    if let popularity = manga.popularity {
                        TagView(value: popularity, label: "Popularity", prefix: "#", color: .yellow)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MangaRow(manga: PreviewData.manga)
}
