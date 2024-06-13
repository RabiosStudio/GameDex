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
    
    func setImageWith(url: URL) {
        self.backgroundColor = .placeholderColor
        self.sd_setImage(with: url) { [weak self] _, _, _, _ in
            self?.backgroundColor = .clear
        }
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image { _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
