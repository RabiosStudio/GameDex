//
//  TitleCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class TitleCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = TitleCell.self
    var indexPath: IndexPath?
    var height: CGFloat = DesignSystem.sizeMedium
    var navigationStyle: NavigationStyle?
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}
