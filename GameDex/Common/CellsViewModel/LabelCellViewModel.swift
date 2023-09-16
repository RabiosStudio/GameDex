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
    var mainText: String
    var optionalText: String?
    
    init(mainText: String, optionalText: String?, screenFactory: ScreenFactory?) {
        self.mainText = mainText
        self.optionalText = optionalText
        self.screenFactory = screenFactory
    }
    
}
