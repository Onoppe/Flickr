//
//  Constants.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

enum Constants {
    static let apiKey = "1508443e49213ff84d566777dc211f2a"
}

extension String {
    static let methodName = "method"
    static let methodValue = "flickr.photos.search"

    static let apiKeyName = "api_key"

    static let textName = "text"

    static let perPageName = "per_page"
    static let perPageValue = "25"

    static let formatName = "format"
    static let formatValue = "json"

    static let noJsonCallbackName = "nojsoncallback"
    static let noJsonCallbackValue = "1"

    static let pageName = "page"
}
