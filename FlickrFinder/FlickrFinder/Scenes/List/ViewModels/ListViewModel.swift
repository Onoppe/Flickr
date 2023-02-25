//
//  ListViewModel.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

final class ListViewModel: ObservableObject {

    // MARK: Private

    private let service: FlickrSearchServicable

    // MARK: Initialiser

    init(service: FlickrSearchServicable) {
        self.service = service
    }
}
