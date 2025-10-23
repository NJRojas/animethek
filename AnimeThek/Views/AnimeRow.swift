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
            AsyncImage(url: anime.images.jpg.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 64, height: 96)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 96)
                        .clipped()
                        .cornerRadius(6)
                case .failure:
                    Rectangle()
                        .fill(.secondary.opacity(0.2))
                        .overlay(Image(systemName: "photo").imageScale(.large))
                        .frame(width: 64, height: 96)
                        .cornerRadius(6)
                @unknown default:
                    EmptyView()
                }
            }

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
