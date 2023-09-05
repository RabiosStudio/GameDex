//
//  InfoCardCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class InfoCardCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = InfoCardCell.self
    var indexPath: IndexPath?
    var title: String
    var description: String
    var imageName: String
    lazy var navigationStyle: NavigationStyle? = {
        guard let screenFactory else { return nil }
        return .push(
            controller: screenFactory.viewController
        )
    }()
    var size: CGFloat = DesignSystem.sizeRegular
    
    private let screenFactory: ScreenFactory?
    
    init(
        title: String,
        description: String,
        imageName: String,
        screenFactory: ScreenFactory?
    ) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.screenFactory = screenFactory
    }
}
