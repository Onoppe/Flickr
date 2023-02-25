//
//  PhotoFeedResponse.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

import Foundation

struct PhotoFeedResponse: Decodable {
    let feed: PhotoFeed
    let stat: String

    private enum CodingKeys: String, CodingKey {
        case feed = "photos"
        case stat
    }
}
