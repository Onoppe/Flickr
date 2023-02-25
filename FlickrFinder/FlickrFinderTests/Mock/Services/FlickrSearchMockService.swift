//
//  FlickrSearchMockService.swift
//  FlickrFinderTests
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation
@testable import FlickrFinder

struct FlickrSearchMockService: Mockable, FlickrSearchServicable {
    func search(with endpoint: Endpoint) async -> Result<PhotoFeedResponse, NetworkError> {
         .success(load(filename: "search_test", type: PhotoFeedResponse.self))
    }
}
