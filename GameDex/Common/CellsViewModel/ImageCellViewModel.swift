//
//  ImageCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

final class ImageCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = ImageCell.self
    var indexPath: IndexPath?
    var height: CGFloat = DesignSystem.sizeBig
    var cellTappedCallback: (() -> Void)?
    
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
}
