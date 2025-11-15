//
//  AnimeViewModelTests.swift
//  AnimeThekTests
//
//  Created by NJ Rojas on 17.11.25.
//

import XCTest
@testable import AnimeThek

@MainActor
final class AnimeViewModelTests: XCTestCase {

    var session: URLSession!
    var client: HTTPClient!
    var viewModel: AnimeViewModel!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)

        client = HTTPClient(session: session)
        viewModel = AnimeViewModel(httpClient: client)
    }

    override func tearDown() {
        session = nil
        client = nil
        viewModel = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    // MARK: - TEST

    func testLoadMoviesSuccessfully() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let imageURL = try XCTUnwrap(URL(string: "https://img"))
        let images = Images(jpg: Jpeg(imageURL: imageURL, smallImageURL: nil, largeImageURL: nil))
        let sampleAnime = Anime(
            id: 1,
            title: "Naruto",
            images: images,
            year: 2002,
            score: 9.0,
            rank: 10,
            synopsis: ""
        )

        let mockResponse = AnimeListResponse(data: [sampleAnime])
        let jsonData = try JSONEncoder().encode(mockResponse)

        MockURLProtocol.requestHandler = { request in
            let http = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (http, jsonData)
        }

        // When
        await viewModel.fetchAnime()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.animeList.count, 1)
        XCTAssertEqual(viewModel.animeList.first?.title, "Naruto")
    }

    func testIsLoadingDuringLoad() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let mockResponse = AnimeListResponse(data: [])
        let jsonData = try JSONEncoder().encode(mockResponse)

        MockURLProtocol.requestHandler = { request in
            let http = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (http, jsonData)
        }

        // When
        XCTAssertFalse(viewModel.isLoading)

        // Since test is running on MainActor
        let task = Task { await viewModel.fetchAnime() }
        // current task is suspended
        await Task.yield()

        // Immediately after calling, isLoading should be true
        XCTAssert(viewModel.isLoading)

        // wait until complete it
        await task.value

        // After finishing, isLoading should be false
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchAnimeErrorMessageOnFailure() async throws {
        // Given
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        // When
        await viewModel.fetchAnime()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssert(viewModel.animeList.isEmpty)
    }
}
