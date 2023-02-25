//
//  DetailView.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        AsyncImage(url: viewModel.photo?.getUrl(using: .normal)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image(systemName: "photo.fill")
        }
        .cornerRadius(10)
        .navigationTitle(viewModel.photo?.title ?? "")
    }
}
