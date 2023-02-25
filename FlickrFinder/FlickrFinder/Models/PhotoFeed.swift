//
//  PhotoFeed.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

struct PhotoFeed: Decodable {

    typealias Photos = [Photo]

    let page: Int
    let pages: Int
    let photos: Photos

    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case photos = "photo"
    }
}
