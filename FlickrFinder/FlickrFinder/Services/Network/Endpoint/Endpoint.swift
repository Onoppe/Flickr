//
//  Endpoint.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

protocol Endpoint {
    var path: String? { get }
    var scheme: String { get }
    var host: String { get }
    var method: Method { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem] { get }
}
