//
//  MangaViewModelTests.swift
//  AnimeThekTests
//
//  Created by NJ Rojas on 17.11.25.
//

import XCTest
@testable import AnimeThek

@MainActor
final class MangaViewModelTests: XCTestCase {

    var session: URLSession!
    var client: HTTPClient!
    var viewModel: MangaViewModel!
    
    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        
        client = HTTPClient(session: session)
        viewModel = MangaViewModel(httpClient: client)
    }

    override func tearDown() {
        viewModel = nil
        client = nil
        session = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func testLoadMediaSuccessfully() async throws {
        // Given
        let url = URL(string: "https://example.com/manga")!
        let imageURL = try XCTUnwrap(URL(string: "https://img"))
        let images = Images(jpg: Jpeg(imageURL: imageURL, smallImageURL: nil, largeImageURL: nil))
        let manga = Manga(
            id: 1,
            title: "Berserk",
            images: images,
            score: 9.5,
            rank: 1,
            status: "publishing",
            chapters: 0,
            volumes: 0,
            popularity: 0,
            synopsis: ""
        )

        let mockResponse = MangaListResponse(data: [manga])
        let jsonData = try JSONEncoder().encode(mockResponse)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, jsonData)
        }

        // When
        await viewModel.loadMedia()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.media.count, 1)
        XCTAssertEqual(viewModel.media.first?.title, "Berserk")
    }
    
    func testIsLoadingTogglesDuringLoad() async throws {
        // Given
        let url = URL(string: "https://example.com/manga")!
        let mockResponse = MangaListResponse(data: [])
        let jsonData = try JSONEncoder().encode(mockResponse)

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, jsonData)
        }

        // Pre-check value
        XCTAssertFalse(viewModel.isLoading)
        // start task
        let task = Task { await viewModel.loadMedia() }
        // Give the async task a chance to start
        await Task.yield()
        // check value
        XCTAssertTrue(viewModel.isLoading)
        // complete task
        await task.value
        // check value
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadMediaSetsErrorMessageOnFailure() async throws {
        // Given
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        // When
        await viewModel.loadMedia()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.media.isEmpty)
    }
}
