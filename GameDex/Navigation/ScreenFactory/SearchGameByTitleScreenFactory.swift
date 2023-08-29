//
//  SearchGameByTitleScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import UIKit

struct SearchGameByTitleScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = SearchGameByTitleViewModel(networkingSession: AlamofireAPI(), platform: self.platform)
        let layoutBuilder = BasicLayoutBuilder(
            cellSize: .regular,
            cellHorizontalSpacing: .small,
            cellVerticalSpacing: .none
        )
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layoutBuilder: layoutBuilder
        )
        return containerController
    }
    
    private let platform: Platform
    
    init(platform: Platform) {
        self.platform = platform
    }
    
}
