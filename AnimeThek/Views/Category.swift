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
}
