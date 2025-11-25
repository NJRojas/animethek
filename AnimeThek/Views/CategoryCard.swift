//
//  CategoryCard.swift
//  AnimeThek
//
//  Created by NJ Rojas on 25.10.25.
//

import SwiftUI

struct CategoryCard: View {

    let category: Category

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .cornerRadius(16)
                .clipped()
            Text(category.title)
                .font(.headline)
                .bold()
                .foregroundStyle(.white)
                .lineLimit(2)
                .padding(.bottom, 10)
                .padding(.trailing, 20)
        }
        .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}


#Preview {
    CategoryCard(category: .anime)
}

// MARK: - Tappable scaling

struct ScaledCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}
