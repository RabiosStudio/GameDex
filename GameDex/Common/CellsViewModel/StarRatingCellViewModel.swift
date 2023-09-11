//
//  StarRatingCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class StarRatingCellViewModel: CollectionFormCellViewModel {
    typealias ValueType = Int
    
    var cellClass: AnyClass = StarRatingCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    let height: CGFloat = DesignSystem.sizeSmall
    
    let title: String
    var formType: FormType = .rating
    var value: ValueType?
    
    init(title: String) {
        self.title = title
    }
}
