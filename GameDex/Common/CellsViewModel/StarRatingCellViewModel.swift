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
    var value: ValueType?
    var formType: FormType
    
    init(title: String,
         formType: FormType,
        self.title = title
        self.formType = formType
    }
}
