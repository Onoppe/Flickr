//
//  PhotoPresmeter.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import SwiftUI

final class PhotoPresenter: ObservableObject {

    func getDetailView(with photo: Photo) -> AnyView {
        let viewModel = DetailViewModel(photo: photo)
        return AnyView(DetailView(viewModel: viewModel))
    }
}
