//
//  Photo+URL.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

extension Photo {

    func getUrl(using size: PhotoSize) -> URL? {
        URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg")
    }
}
