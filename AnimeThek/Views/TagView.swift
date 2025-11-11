//
//  TagView.swift
//  AnimeThek
//
//  Created by NJ Rojas on 11.11.25.
//

import SwiftUI

struct TagView: View {
    
    let value: Int
    let label: String
    var prefix: String = ""
    let color: Color

    var body: some View {
        Text(value.tagString(label: label, prefix: prefix))
            .padding(4)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(4)
    }
}

#Preview {
    TagView(value: 12, label: "Popularity", prefix: "#", color: .yellow)
}
