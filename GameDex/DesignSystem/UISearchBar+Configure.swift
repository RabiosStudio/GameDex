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
        self.clearButtonColor = .primaryColor
        self.searchIconColor = .primaryColor
    }
    
    // Button/Icon images
    var clearButtonImage: UIImage?
    var searchImage: UIImage?
    
    // Button/Icon colors
    var searchIconColor: UIColor?
    var clearButtonColor: UIColor?
    
    private enum SubviewKey: String {
        case searchField, clearButton
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let textField = self.value(forKey: SubviewKey.searchField.rawValue) as? UITextField else { return }
        
        if let clearButton = textField.value(forKey: SubviewKey.clearButton.rawValue) as? UIButton {
            update(button: clearButton, image: clearButtonImage, color: clearButtonColor)
        }
        if let searchView = textField.leftView as? UIImageView {
            searchView.image = (searchImage ?? searchView.image)?.withRenderingMode(.alwaysTemplate)
            if let color = searchIconColor {
                searchView.tintColor = color
            }
        }
    }
    
    private func update(button: UIButton, image: UIImage?, color: UIColor?) {
        let image = (image ?? button.currentImage)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        if let color = color {
            button.tintColor = color
        }
    }
}
