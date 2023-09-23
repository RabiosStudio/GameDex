//
//  ButtonCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class ButtonCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = ButtonCell.self
    var indexPath: IndexPath?
    var height: CGFloat = DesignSystem.buttonHeightRegular
    var navigationStyle: NavigationStyle?
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}
