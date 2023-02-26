//
//  String+Localizable.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 26/02/2023.
//

import Foundation

extension String {

    var localized: String{
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }

    func localized(with arguments: CVarArg...) -> String{
        String(format: localized, arguments: arguments)
    }
}
