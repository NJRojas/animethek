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
            rank: 160,
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
    
    static var manga: Manga {
        Manga(
            id: 3,
            title: "20th Century Boys",
            images: Images(jpg: mangeJPEG),
            score: 7.31,
            rank: 160,
            status: "Finished",
            chapters: 240,
            volumes: 22,
            popularity: 24,
            synopsis: "As the 20th century approaches its end, people all over the world are anxious that the world is changing. And probably not for the better. Kenji Endou is a normal convenience store manager who is just trying to get by. But when he learns that one of his old friends going by the name \"Donkey\" has suddenly committed suicide and that a new cult led by a figure known as \"Friend\" is becoming more notorious, Kenji starts to feel that something is not right. With a few key clues left behind by his deceased friend, Kenji realizes that this cult is much more than he ever thought it would be—not only is this mysterious organization directly targeting him and his childhood friends, but the whole world also faces a grave danger that only the friends have the key to stop. Kenji's simple life of barely making ends meet is flipped upside down when he reunites with his childhood friends, and together they must figure out the truth of how their past is connected to the cult, as the turn of the century could mean the possible end of the world. [Written by MAL Rewrite]"
        )
    }
    
    static var mangeJPEG: Jpeg {
        Jpeg(
            imageURL: URL(string: "https://cdn.myanimelist.net/images/manga/5/260006.jpg")!,
            smallImageURL: nil,
            largeImageURL: nil
        )
    }
}
