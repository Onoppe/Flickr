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
            VStack {
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
                    .navigationTitle("Flickr Search".localized)
                }
                if self.viewModel.shouldLoadMore {
                    Button("Load more".localized) {
                        Task {
                            await viewModel.fetchItems(loadMore: true)
                        }
                    }
                }
            }
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
                await viewModel.fetchItems()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchItems()
            }
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.networkError) {
            Button("Retry".localized) {
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
