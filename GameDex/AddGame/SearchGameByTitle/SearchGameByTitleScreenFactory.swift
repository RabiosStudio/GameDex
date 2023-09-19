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
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: AlamofireAPI(),
            platform: self.platform,
            gameDetailsDelegate: self.gameDetailsDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    private let platform: Platform
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    init(platform: Platform, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.platform = platform
        self.gameDetailsDelegate = gameDetailsDelegate
    }
    
}
