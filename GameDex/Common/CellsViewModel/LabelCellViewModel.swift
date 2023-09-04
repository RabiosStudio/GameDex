//
//  LabelCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation

final class LabelCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = LabelCell.self
    var indexPath: IndexPath?
    var text: String
    lazy var navigationStyle: NavigationStyle? = {
        guard let screenFactory else { return nil }
        return .push(
            controller: screenFactory.viewController
        )
    }()
    
    private let screenFactory: ScreenFactory?
    
    init(text: String, screenFactory: ScreenFactory?) {
        self.text = text
        self.screenFactory = screenFactory
    }
    
}
