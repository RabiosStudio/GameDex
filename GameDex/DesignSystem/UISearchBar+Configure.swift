//
//  UISearchBar+Configure.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 26/08/2023.
//

import Foundation
import UIKit

class SearchBar: UISearchBar {
    func configure() {
        self.tintColor = .primaryColor
        self.barStyle = .default
        self.sizeToFit()
        self.setUpIcons(with: .primaryColor)
    }
    
    private func setUpIcons(with tintColor: UIColor) {
        // button/icon images
        let clearImage = UIImage(systemName: "xmark.circle.fill")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        
        // setup search icon
            self.setImage(searchImage, for: .search, state: .normal)
        // setup clear icon
            self.setImage(clearImage, for: .clear, state: .normal)
    }
}
