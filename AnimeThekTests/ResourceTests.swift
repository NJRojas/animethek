//
//  ResourceTests.swift
//  AnimeThekTests
//
//  Created by NJ Rojas on 17.11.25.
//

import XCTest
@testable import AnimeThek

final class ResourceTests: XCTestCase {

    func testResourceStoresGETMethodCorrectly() throws {
        // Given
        let url = try XCTUnwrap(URL(string: "https://api.jikan.moe/v4/anime"))
        let queryItems = [
            URLQueryItem(name: "q", value: "Naruto"),
            URLQueryItem(name: "page", value: "1")
        ]

        // When
        let resource = Resource(
            url: url,
            method: .get(queryItems),
            headers: nil,
            modelType: Anime.self
        )

        // Then
        switch resource.method {
            case .get(let items):
                XCTAssertEqual(items.count, 2)

                // They may not be in order, so we assert independently:
                XCTAssertTrue(items.contains(URLQueryItem(name: "q", value: "Naruto")))
                XCTAssertTrue(items.contains(URLQueryItem(name: "page", value: "1")))
            default:
                XCTFail("Expected GET method")
        }
    }

    func testGETMethodAllowsEmptyQueryItems() throws {
        let url = try XCTUnwrap(URL(string: "https://api.jikan.moe/v4/anime"))

        let resource = Resource(
            url: url,
            method: .get([]),
            headers: nil,
            modelType: Anime.self
        )

        switch resource.method {
            case .get(let items):
                XCTAssertTrue(items.isEmpty)
            default:
                XCTFail("Expected GET method")
        }
    }

    // Resource correctly stores the URL
    func testResourceStoresHTTPMethodCorrectly() throws {

        // Given
        /// If URL nil, test failed with a clear message, but no crash.
        let url = try XCTUnwrap(
            URL(string: "https://api.jikan.moe/v4/anime")
        )
        let json = ["sample": "value"]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)

        // When
        let resource = Resource(
            url: url,
            method: .post(jsonData),
            headers: nil,
            modelType: Anime.self
        )

        // Then
        switch resource.method {
            case .post(let bodyData):
                XCTAssertNotNil(bodyData)
                XCTAssertEqual(bodyData, jsonData)
            
                // Optional: decode to verify it's the same JSON structure
                let decoded = try! JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: String]
                XCTAssertEqual(decoded, json)
            default:
                XCTFail("Expected POST method")
        }
    }
}
