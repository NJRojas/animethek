//
//  ContentView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var model = AnimeViewModel()

    var body: some View {
        
        NavigationView {
        
            Group {
                if model.isLoading && model.movies.isEmpty {
                    ProgressView("Loading movies…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let err = model.errorMessage, model.movies.isEmpty {
                    VStack(spacing: 12) {
                        Text("Couldn’t load movies")
                            .font(.headline)
                        Text(err).font(.callout).foregroundStyle(.secondary).multilineTextAlignment(.center)
                        Button("Retry") { Task { await model.load() } }
                            .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(model.movies) { anime in
                        NavigationLink {
                            AnimeDetailView(anime: anime)
                        } label: {
                            AnimeRow(anime: anime)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await model.load()
                    }
                }
            }
            .navigationTitle("Anime Movies")
        }
        .task { await model.load() }
    }
}

#Preview {
    MainView()
}
