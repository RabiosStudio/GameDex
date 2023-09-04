//
//  StarRatingCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class StarRatingCellViewModel: CellViewModel {
    var cellClass: AnyClass = StarRatingCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
