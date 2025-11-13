//
//  DownloadableImageView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 10.11.25.
//

import SwiftUI

enum ImageType {
    case thumbnail
    case detail
}

struct DownloadableImageView: View {

    let url: URL?
    let type: ImageType

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    emptyView()
                case .success(let image):
                    imageView(image)

                case .failure:
                    rectangle()
                @unknown default:
                    EmptyView()
            }
        }
    }

    @ViewBuilder
    private func emptyView() -> some View {
        switch type {
            case .thumbnail:
                ProgressView()
                    .frame(width: 64, height: 96)
            case .detail:
                ZStack {
                    Rectangle().fill(.secondary.opacity(0.1))
                    ProgressView()
                }
                .frame(height: 280)
        }
    }
    
    @ViewBuilder
    private func imageView(_ img: Image) -> some View {
        switch type {
            case .thumbnail:
                img
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 96)
                .clipped()
                .cornerRadius(6)
            case .detail:
                img
                .resizable()
                .scaledToFill()
                .frame(height: 280)
                .clipped()
        }
    }
    
    @ViewBuilder
    private func rectangle() -> some View {
        switch type {
            case .thumbnail:
                Rectangle()
                    .fill(.secondary.opacity(0.2))
                    .overlay(
                        Image(systemName: "photo")
                            .imageScale(.large)
                    )
                    .frame(width: 64, height: 96)
                    .cornerRadius(6)
            case .detail:
                Rectangle()
                    .fill(.secondary.opacity(0.1))
                    .overlay(
                        Image(systemName: "photo")
                            .imageScale(.large)
                    )
                    .frame(height: 280)
        }
    }
}

#Preview {
    DownloadableImageView(
        url: PreviewData.anime.images.jpg.imageURL,
        type: .thumbnail
    )
}
