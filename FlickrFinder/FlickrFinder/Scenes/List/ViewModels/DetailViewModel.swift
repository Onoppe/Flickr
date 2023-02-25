//
//  DetailViewModel.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

final class DetailViewModel: ObservableObject {

    @Published var photo: Photo?

    init(photo: Photo? = nil) {
        self.photo = photo
    }
}

