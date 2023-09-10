//
//  StarRatingCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class StarRatingCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = StarRatingCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    let size: CGFloat = DesignSystem.sizeSmall
    var rating: Double
    
    let title: String
    
    init(title: String) {
        self.title = title
        self.rating = .zero
    }
}
