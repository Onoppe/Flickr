//
//  FlickrSearchServicable.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

protocol FlickrSearchServicable {
    func search(with endpoint: Endpoint) async -> Result<PhotoFeedResponse, NetworkError>
}
