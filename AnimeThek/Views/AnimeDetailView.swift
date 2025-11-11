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
                AsyncImage(url: anime.images.jpg.largeImageURL ?? anime.images.jpg.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ZStack { Rectangle().fill(.secondary.opacity(0.1)) ; ProgressView() }
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
                    Text(anime.title).font(.title2).bold()
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
