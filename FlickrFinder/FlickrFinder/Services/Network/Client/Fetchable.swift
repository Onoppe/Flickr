//
//  Fetchable.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

protocol Fetchable {
    func fetch<T: Decodable>(_ endpoint: Endpoint,
                             model: T.Type) async -> Result<T, NetworkError>
}
