//
//  FlickrFinderApp.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import SwiftUI

@main
struct FlickrFinderApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(presenter: PhotoPresenter())
        }
    }
}
