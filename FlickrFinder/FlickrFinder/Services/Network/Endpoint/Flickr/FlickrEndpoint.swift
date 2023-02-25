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
                URLQueryItem(name: .methodName, value: .methodValue),
                URLQueryItem(name: .apiKeyName, value: Constants.apiKey),
                URLQueryItem(name: .textName, value: text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)),
                URLQueryItem(name: .perPageName, value: .perPageValue),
                URLQueryItem(name: .formatName, value: .formatValue),
                URLQueryItem(name: .noJsonCallbackName, value: .noJsonCallbackValue),
                URLQueryItem(name: .pageName, value: "\(page)")]
        }
    }
}
