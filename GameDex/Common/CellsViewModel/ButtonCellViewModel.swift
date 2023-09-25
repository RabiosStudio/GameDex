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
    
    lazy var navigationStyle: NavigationStyle? = {
        guard let screenFactory else { return nil }
        return .push(
            controller: screenFactory.viewController
        )
    }()
    
    private let screenFactory: ScreenFactory?
    
    let title: String
    
    init(title: String, screenFactory: ScreenFactory?) {
        self.title = title
        self.screenFactory = screenFactory
    }
    
}
