//
//  FlickrEndpoint.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

enum FlickrEndpoint {
    case search(text: String, page: Int)
}

// MARK: - Endpoint Methods

extension FlickrEndpoint: Endpoint  {

    var method: Method {
        .get
    }

    var header: [String : String]? {
        ["Content-Type": "application/json"]
    }

    var scheme: String {
        "https"
    }

    var host: String {
        "api.flickr.com"
    }

    var path: String {
        "/services/rest/"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let text, let page):
            return [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: Constants.apiKey),
                URLQueryItem(name: "text", value: text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)),
                URLQueryItem(name: "per_page", value: "25"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "page", value: "\(page)")]
        }
    }
}
