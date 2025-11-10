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
        /* ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [category.tint.opacity(0.25), category.tint.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(category.tint.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 10, y: 6)

            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: category.image)
                    .font(.system(size: 28, weight: .semibold))
                    .padding(10)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .foregroundStyle(category.tint)

                Text(category.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                if let subtitle = category.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                Spacer()
            }
            .padding(16)
        } */
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
