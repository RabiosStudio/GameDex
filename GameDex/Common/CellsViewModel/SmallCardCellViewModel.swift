//
//  SmallCardCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class SmallCardCellViewModel: CollectionCardCellViewModel {
    var cellClass: AnyClass = SmallCardCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var height: CGFloat = DesignSystem.sizeVerySmall
    var cardType: CardType
    var cardTitle: String
    
    init(cardType: CardType, title: String) {
        self.cardType = cardType
        self.cardTitle = title
    }
}
