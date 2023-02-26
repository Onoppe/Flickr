//
//  ListView.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import SwiftUI

struct ListView: View {

    @ObservedObject var viewModel = ListViewModel(service: FlickrSearchService())
    @ObservedObject private var presenter: PhotoPresenter

    init(presenter: PhotoPresenter) {
        self.presenter = presenter
    }

    var body: some View {
        NavigationView {
            List(viewModel.photos) { photo in
                NavigationLink(destination: presenter.getDetailView(with: photo)) {

                    HStack {
                        AsyncImage(url: photo.getUrl(using: .thumbnail)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "photo.fill")
                        }.frame(width: 50, height: 50)
                            .cornerRadius(10)
                        Text(photo.title ?? "")
                    }
                }

                .listStyle(GroupedListStyle())
                .navigationTitle("Flickr Search")
            }
            .refreshable {
                if self.viewModel.shouldLoadMore {
                    await viewModel.fetchItems(loadMore: true)
                }
            }
            .navigationTitle("Flickr Search")
        }
        .searchable(text: $viewModel.searchText)
        .searchSuggestions {
            ForEach(viewModel.historySearches, id: \.self) { text in
                if text
                    .starts(with: viewModel.searchText) {
                    Text(text).searchCompletion(text)
                }
            }
        }
        .onSubmit(of: .search) {
            Task {
                await viewModel.fetchItems(loadMore: false)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchItems(loadMore: false)
            }
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.networkError) {
            Button("Retry") {
                Task {
                    await viewModel.fetchItems()
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(presenter: PhotoPresenter())
    }
}
