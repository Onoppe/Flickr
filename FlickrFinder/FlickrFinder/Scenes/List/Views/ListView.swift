//
//  ListView.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import SwiftUI

struct ListView: View {

    @ObservedObject var viewModel = ListViewModel(service: FlickrSearchService())

    var body: some View {
        NavigationView {
            List(viewModel.photos) { photo in

                HStack {
                    AsyncImage(url: photo.getUrl(using: .thumbnail))
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                    Text(photo.title ?? "")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Flickr Search")
        }
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search) {
            Task {
                await viewModel.fetchItems()
            }
        }
        .task {

        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
