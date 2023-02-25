//
//  Photo.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

struct Photo: Decodable, Identifiable {
    let id: String
    let farm: Int
    let server: String
    let secret: String
    let title: String?
}
