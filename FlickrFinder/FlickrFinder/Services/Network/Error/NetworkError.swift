//
//  NetworkError.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noResponse
    case decode
    case statusCode
    case unauthorized
    case unknown
}
