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

    // MARK: Internal

    @Published var photos: PhotoFeed.Photos = []
    @Published var searchText = ""

    // MARK: Initialiser

    init(service: FlickrSearchServicable) {
        self.service = service
    }
}

// MARK: - Internal Methods

extension ListViewModel {

    func getItems() {
        Task(priority: .background) {
            await fetchItems()
        }
    }
}

// MARK: - Private Helper Methods


extension ListViewModel {

    private func fetchItems() async {
        let result = await service.search(with: FlickrEndpoint.search(text: searchText, page: 0))

        switch result {
        case .success(let response):
            await MainActor.run { [weak self] in
                guard let self else { return }

                self.photos = response.feed.photos
            }
        default:
            break
        }
    }
}
