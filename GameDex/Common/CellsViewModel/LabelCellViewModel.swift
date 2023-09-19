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
    lazy var navigationStyle: NavigationStyle? = {
        guard let screenFactory else { return nil }
        return .push(
            controller: screenFactory.viewController
        )
    }()
    var height: CGFloat = DesignSystem.sizeTiny
    
    private let screenFactory: ScreenFactory?
    var primaryText: String
    var secondaryText: String?
    
    init(mainText: String, optionalText: String?, screenFactory: ScreenFactory?) {
        self.primaryText = mainText
        self.secondaryText = optionalText
        self.screenFactory = screenFactory
    }
    
}
