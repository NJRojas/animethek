//
//  ContentView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import SwiftUI

struct MainView: View {

    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

       var body: some View {
           NavigationStack {
               ScrollView {
                   LazyVGrid(columns: columns, spacing: 16) {
                       ForEach(Category.allCases, id: \.self) { category in
                           NavigationLink(value: category) {
                               CategoryCard(category: category)
                           }
                           .buttonStyle(ScaledCardButtonStyle())
                       }
                   }
                   .padding(16)
               }
               .navigationTitle("Anime Mediathek")
               .navigationDestination(for: Category.self) { category in
                   category.destination
               }
           }
       }
}

#Preview {
    MainView()
}
