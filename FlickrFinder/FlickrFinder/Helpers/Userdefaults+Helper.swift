//
//  Userdefaults+Helper.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

final class Persistance {

    // MARK: Internal

    static var userDefaults = UserDefaults.standard

    static var historySearches: [String]? {
        get {
            userDefaults.object(forKey: .historySearches) as? [String]
        }
        set {
            userDefaults.set(newValue, forKey: .historySearches)
        }
    }
}
