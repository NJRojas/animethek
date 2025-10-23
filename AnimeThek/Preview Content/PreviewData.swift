//
//  PreviewData.swift
//  AnimeThek
//
//  Created by NJ Rojas on 22.10.25.
//

import Foundation

struct PreviewData {

    static var anime: Anime {
        Anime(
            id: 1,
            title: "Aa! Megami-sama! (TV)",
            images: images,
            year: 2005,
            score: 7.31,
            synopsis: "In a world where humans can have their wish granted via the Goddess Help Hotline, a human, Keiichi Morisato, summons the Goddess Belldandy by accident and jokes that she should stay with him forever. Unfortunately for him, his \"wish\" is granted. Suddenly, Keiichi is now living with this gorgeous woman all alone, causing him to be kicked out of the all-male dormitory he was staying in. But soon, after they find lodging in a Buddhist temple, Keiichi and Belldandy's relationship begins to blossom. Although they are both awkward and rather uncomfortable with one another at first, what awaits these two strangers could turn out to be an unexpected romance. [Written by MAL Rewrite]"
        )
    }
    
    static var images: Images {
        Images(jpg: jpeg)
    }
    
    static var jpeg: Jpeg {
        Jpeg(
            imageURL: URL(string: "https://cdn.myanimelist.net/images/anime/1976/99376.jpg")!,
            smallImageURL: nil,
            largeImageURL: nil
        )
    }
}
