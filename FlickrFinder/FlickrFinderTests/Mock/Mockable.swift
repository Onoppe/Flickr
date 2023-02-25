//
//  Mockable.swift
//  FlickrFinderTests
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

protocol Mockable {
    func load<T: Decodable>(filename: String, type: T.Type) -> T
}

// MARK: - Public

extension Mockable {

    func load<T: Decodable>(filename: String, type: T.Type) -> T {

        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Could not load JSON")
        }

        do {
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(type, from: data)

            return model
        } catch {
            fatalError("Something went wrong: \(error.localizedDescription)")
        }
    }
}
