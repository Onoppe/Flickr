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

    @Published private(set) var networkError: NetworkError?

    // MARK: Internal

    @Published var photos: PhotoFeed.Photos = []
    @Published var searchText = "WarnerBros"
    @Published var historySearches: [String] = []
    @Published var hasError = false


    private var currentPage: Int = 1
    private var totalOfPages: Int? = nil

    var shouldLoadMore: Bool {
        guard let totalPages = totalOfPages else { return false }
        return currentPage < totalPages
    }

    // MARK: Initialiser

    init(service: FlickrSearchServicable) {
        self.service = service
    }
}

// MARK: - Internal Methods

extension ListViewModel {

    @MainActor
    func fetchItems(loadMore: Bool = false) async {
        let result = await service.search(with: FlickrEndpoint.search(text: searchText, page: currentPage))

        switch result {
        case .success(let response):

                if loadMore {
                    self.photos.append(contentsOf: response.feed.photos)
                } else {
                    self.photos = response.feed.photos

                    // New photos fetched, so save the search text
                    saveHistorySearches()
                }

                // Check the total and current page(s)
                setPages(using: response)
                currentPage += 1
        case .failure(let error):
            hasError = true
            networkError = error
        }
    }
}

// MARK: - Private Helper Methods

extension ListViewModel {

    private func saveHistorySearches() {
        guard !historySearches.contains(searchText) else { return }

        historySearches.insert(searchText, at: 0)
        Persistance.historySearches = historySearches
    }

    private func setPages(using response: PhotoFeedResponse) {
        totalOfPages = response.feed.pages
        currentPage = response.feed.page
    }
}
