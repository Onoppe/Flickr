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
    @Published var historySearches: [String] = []

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

    func fetchItems(loadMore: Bool) async {
        let result = await service.search(with: FlickrEndpoint.search(text: searchText, page: currentPage))

        switch result {
        case .success(let response):
            await MainActor.run { [weak self] in
                guard let self else { return }

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
            }
        default:
            break
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
