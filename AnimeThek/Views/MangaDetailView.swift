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
                AsyncImage(url: manga.images.jpg.largeImageURL ?? manga.images.jpg.imageURL) { phase in
                    switch phase {
                        case .empty:
                            ZStack {
                                Rectangle().fill(.secondary.opacity(0.1)) ; ProgressView()
                            }
                            .frame(height: 280)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .clipped()
                        case .failure:
                            Rectangle()
                                .fill(.secondary.opacity(0.1))
                                .overlay(Image(systemName: "photo").imageScale(.large))
                                .frame(height: 280)
                        @unknown default:
                            EmptyView()
                    }
                }
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

#Preview {
    NavigationStack {
        MangaDetailView(manga: PreviewData.manga)
    }
}
