//
//  ContentView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import SwiftUI

struct MainView: View {

    var body: some View {

        NavigationStack {
            List(Category.allCases, id: \.self) { category in
                NavigationLink {
                    category.destination
                } label: {
                    category.row
                }
            }
            .navigationTitle("Anime Mediathek")
        }
    }
}

#Preview {
    MainView()
}
