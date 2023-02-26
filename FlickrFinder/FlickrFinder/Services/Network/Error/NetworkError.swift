//
//  NetworkError.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

enum NetworkError {
    case invalidUrl
    case noResponse
    case decode
    case statusCode
    case unauthorized
    case unknown(Error)
}

// MARK: - LocalizedError

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "The URL is not valid"
        case .noResponse:
            return "We couldn't get a response right now"
        case .decode:
            return "We failed to decode"
        case .unauthorized:
            return "You are unauthorized"
        case .statusCode:
            return "We got the wrong statusCode"
        case .unknown(let error):
            return "Something went wrong: \(error.localizedDescription)"
        }
    }
}
