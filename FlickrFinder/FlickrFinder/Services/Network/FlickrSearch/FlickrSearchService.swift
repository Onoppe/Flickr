//
//  FlickrSearchService.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

struct FlickrSearchService: Fetchable, FlickrSearchServicable {

    func search(with endpoint: Endpoint) async -> Result<PhotoFeedResponse, NetworkError> {
        await fetch(endpoint, model: PhotoFeedResponse.self)
    }
}
