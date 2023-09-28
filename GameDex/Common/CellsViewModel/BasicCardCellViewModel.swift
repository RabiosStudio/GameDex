//
//  BasicCardCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class BasicCardCellViewModel: CollectionCardCellViewModel {
    var cellClass: AnyClass = BasicCardCell.self
    var indexPath: IndexPath?
    var cardTitle: String
    var cardDescription: String?
    var cardType: CardType
    lazy var height: CGFloat = self.cardType.height
    var cellTappedCallback: (() -> Void)?

    init(cardType: CardType,
         title: String,
         description: String? = nil,
         cellTappedCallback: (() -> Void)? = nil
    ) {
        self.cardType = cardType
        self.cardTitle = title
        self.cardDescription = description
        self.cellTappedCallback = cellTappedCallback
    }
}
