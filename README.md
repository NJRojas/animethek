# Animethek

A lightweight iOS sample application demonstrating how to build a modern SwiftUI app that displays Anime and Manga metadata using the free public API from Jikan.moe.

AnimeThek illustrates clean architecture design, async networking, list rendering, image loading, and navigation using SwiftUI, URLSession, and Swift Concurrency.

## Features

A list of sample implementations

- Two media categories: Anime & Manga
- REST API integration with Jikan.moe
- SwiftUI NavigationStack with typed navigation
- AsyncImage-based image loading
- Reusable row views (AnimeRow, MangaRow)
- Searchable lists (optional extension)
- Pull-to-refresh
- Codable models matching the Jikan REST schema
- Separation of concerns: Model ⇢ ViewModel ⇢ View
- Text views looks like tags
- Usage of AttributedStrings

## Architecture Overview

![App Diagram](./Diagrams/AppDiagram.png)

## Getting Started

- Clone the repository:

```sh
    git clone https://github.com/NJRojas/animethek.git
```
- Open Project

```
    open AnimeThek.xcodeproj
```
