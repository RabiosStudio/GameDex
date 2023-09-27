//
//  LabelCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation

final class LabelCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = LabelCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var height: CGFloat = DesignSystem.sizeTiny
    var primaryText: String
    var secondaryText: String?
    
    init(primaryText: String, secondaryText: String? = nil, navigationStyle: NavigationStyle?) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.navigationStyle = navigationStyle
    }
    
}
