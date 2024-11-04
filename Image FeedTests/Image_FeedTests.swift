//
//  Image_FeedTests.swift
//  Image FeedTests
//
//  Created by Maksim Zakharov on 31.10.2024.
//


@testable import ImageFeed
import XCTest
import Testing

final class ImagesListServiceTests: XCTestCase {
    func testExample() {
        let service = ImagesListService.shared
        
        let expectation = self.expectation(description: "Wait for Notification")
        NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { _ in
                expectation.fulfill()
            }
        
        service.fetchPhotosNextPage { result in
        }
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(service.photos.count, 10)
    }
}
