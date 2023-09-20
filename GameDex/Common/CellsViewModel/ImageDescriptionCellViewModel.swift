//
//  ImageDescriptionCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class ImageDescriptionCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = ImageDescriptionCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var height: CGFloat = DesignSystem.sizeVeryBig
    
    let imageStringURL: String
    let title: String
    let subtitle1: String
    let subtitle2: String?
    let subtitle3: String
    
    init(imageStringURL: String,
         title: String,
         subtitle1: String,
         subtitle2: String?,
         subtitle3: String
    ) {
        self.imageStringURL = imageStringURL
        self.title = title
        self.subtitle1 = subtitle1
        self.subtitle2 = subtitle2
        self.subtitle3 = subtitle3
    }
    
}
