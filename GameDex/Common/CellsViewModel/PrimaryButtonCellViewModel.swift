//
//  PrimaryButtonCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class PrimaryButtonCellViewModel: ButtonCollectionCellViewModel {
    var cellClass: AnyClass = PrimaryButtonCell.self
    var indexPath: IndexPath?
    var height: CGFloat = DesignSystem.buttonHeightRegular
    
    lazy var navigationStyle: NavigationStyle? = {
        guard let screenFactory else { return nil }
        return .push(
            controller: screenFactory.viewController
        )
    }()
    
    private let delegate: PrimaryButtonDelegate?
    private let screenFactory: ScreenFactory?
    
    let title: String
    
    init(title: String, screenFactory: ScreenFactory?, delegate: PrimaryButtonDelegate?) {
        self.title = title
        self.delegate = delegate
        self.screenFactory = screenFactory
    }
    
    func didTapButton() {
        guard let delegate = self.delegate else {
            guard let navigationStyle = self.navigationStyle else { return }
            _ =  Routing.shared.route(navigationStyle: navigationStyle)
            return
        }
        delegate.didTapPrimaryButton()
    }
}
