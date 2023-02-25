//
//  FlickrFinderTests.swift
//  FlickrFinderTests
//
//  Created by Omar Noppe on 25/02/2023.
//

import XCTest
@testable import FlickrFinder

final class FlickrFinderTests: XCTestCase {

    func test_fetching_photos_successfully() throws {
        let viewModel = ListViewModel(service: FlickrSearchMockService())

        let expectation = expectation(description: "Fetch data from service")

        Task(priority: .background) {
            await viewModel.fetchItems()

            XCTAssertEqual(viewModel.photos.count, 25)
            XCTAssertEqual(viewModel.photos.first?.title, "PMG_Genevieve showing DDD photograph housing on tour_DSC_2863")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

}
