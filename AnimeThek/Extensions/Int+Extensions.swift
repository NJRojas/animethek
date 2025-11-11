//
//  Int+Extensions.swift
//  AnimeThek
//
//  Created by NJ Rojas on 11.11.25.
//

import Foundation

extension Int {
    
    func tagString(label: String, prefix: String = "") -> AttributedString {
        var attributedString = AttributedString("\(label) \(prefix)\(Int(self))")

        // Set base style
        attributedString.font = .systemFont(ofSize: 12)
        attributedString.foregroundColor = .white

        // Make rank number bold
        if let range = attributedString.range(of: "\(prefix)\(Int(self))") {
            attributedString[range].font = .boldSystemFont(ofSize: 12)
        }
        return attributedString
    }
}
