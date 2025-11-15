//
//  HTTPClientTests.swift
//  AnimeThekTests
//
//  Created by NJ Rojas on 16.11.25.
//

@testable import AnimeThek
import XCTest

final class HTTPClientTests: XCTestCase {

    var client: HTTPClient!
    var session: URLSession!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]

        session = URLSession(configuration: config)
        client = HTTPClient(session: session)
    }

    override func tearDown() {
        client = nil
        session = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDownWithError() throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        MockURLProtocol.requestHandler = nil
        try super.tearDownWithError()
    }

    // MARK: - Test

    func testHTTPClientSuccessCase() async throws {

        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let imageURL = try XCTUnwrap(URL(string: "https://img"))
        let images = Images(jpg: Jpeg(imageURL: imageURL, smallImageURL: nil, largeImageURL: nil))
        let expectedAnime = Anime(id: 1, title: "Naruto", images: images, year: 2002, score: 9.0, rank: 20, synopsis: "")

        let resource = Resource(url: url, headers: nil, modelType: Anime.self)

        // Encode model into JSON to simulate server response
        let jsonData = try JSONEncoder().encode(expectedAnime)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }

        // When
        let result = try await client.load(resource)

        // Then
        XCTAssertEqual(result.id, expectedAnime.id)
        XCTAssertEqual(result.title, expectedAnime.title)
    }

    func testHTTPClient404ReturnsResponseError() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let resource = Resource(url: url, headers: nil, modelType: Anime.self)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // When & Then
        do {
            _ = try await client.load(resource)
            XCTFail("Expected an error to be thrown")
        } catch let error as NetworkError {

            switch error {
                case .errorResponse(let err):
                    // The message is generated as: "HTTP 404: <snippet>"
                    XCTAssertTrue(err.message?.contains("HTTP 404") == true)
                default:
                    XCTFail("Expected .errorResponse but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // MARK: - FAILURE: Invalid JSON → .decodingError
    
    func testHTTPClientInvalidJSONDecodingError() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let resource = Resource(url: url, headers: nil, modelType: Anime.self)
        let invalidJSON = "{ invalid json }".data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, invalidJSON)
        }

        // When & Then
        do {
            _ = try await client.load(resource)
            XCTFail("Expected decodingError but load() succeeded")
        } catch let error as NetworkError {
            switch error {
                case .decodingError:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Expected .decodingError but got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testHTTPClientNoInternetReturnsNoInternetError() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let resource = Resource(url: url, headers: nil, modelType: Manga.self)

        MockURLProtocol.requestHandler = { request in
            let error = URLError(.notConnectedToInternet)
            throw error
        }

        // When & Then
        do {
            _ = try await client.load(resource)
            XCTFail("Expected failure because no internet connection")
        } catch let error as NetworkError {
            switch error {
                case .errorResponse(let response):
                    XCTAssertEqual(response.message, "No internet connection")
                default:
                    XCTFail("Expected errorResponse but got: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testHTTPClientTimeoutReturnsTimeoutError() async throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://example.com/anime"))
        let resource = Resource(url: url, headers: nil, modelType: Manga.self)

        // When & Then
        MockURLProtocol.requestHandler = { request in
            throw URLError(.timedOut)
        }

        do {
            _ = try await client.load(resource)
            XCTFail("Expected timeout error")
        } catch let error as NetworkError {
            switch error {
                case .errorResponse(let response):
                    XCTAssertEqual(response.message, "Request timed out")
                default:
                    XCTFail("Expected errorResponse message: timeout but got: \(error)")
            }
        } catch {
            XCTFail("Expected timeout error")
        }

    }
}
