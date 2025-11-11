//
//  DownloadableImageView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 10.11.25.
//

import SwiftUI

struct DownloadableImageView: View {

    let url: URL?
    var width: CGFloat = 64
    var height: CGFloat = 96
    var cornerRadius: CGFloat = 6
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: width, height: height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(cornerRadius)
                case .failure:
                    Rectangle()
                        .fill(.secondary.opacity(0.2))
                        .overlay(Image(systemName: "photo").imageScale(.large))
                        .frame(width: width, height: height)
                        .cornerRadius(cornerRadius)
                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview {
    DownloadableImageView(url: PreviewData.anime.images.jpg.imageURL)
}
