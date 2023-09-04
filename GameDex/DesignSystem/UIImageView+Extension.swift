//
//  UIImageView+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import SDWebImage

extension UIImageView {
    func setImageWith(url: URL, placeholderImage: UIImage) {
        self.sd_setImage(
            with: url,
            placeholderImage: placeholderImage
        )
    }
}
