//
//  Category.swift
//  AnimeThek
//
//  Created by NJ Rojas on 24.10.25.
//

import SwiftUI

enum Category: Hashable, Identifiable, CaseIterable {

    case anime
    case manga

    var id: Category { self }

    @ViewBuilder
    var row: some View {
        switch self {
            case .anime:
                Text("Anime")
            case .manga:
                Text("Manga")
        }
    }

    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
            case .anime:
                AnimeMoviesList()

            case .manga:
                MangaList()
        }
    }

    var image: String {
        switch self {
            case .anime: "anime"
            case .manga: "manga"
        }
    }

    var title: String {
        switch self {
            case .anime: "Anime"
            case .manga: "Manga"
        }
    }

    var subtitle: String? {
        switch self {
            case .anime: "Anime"
            case .manga: "Manga"
        }
    }

    var tint: Color {
        switch self {
            case .anime: .blue
            case .manga: .mint
        }
    }
}
