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
        if self.addToNavController {
            let navigationController = UINavigationController(
                rootViewController: containerController
            )
            return navigationController
        } else {
            return containerController
        }
    }
    
    private let platform: Platform
    private let addToNavController: Bool
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    init(platform: Platform, gameDetailsDelegate: GameDetailsViewModelDelegate?, addToNavController: Bool = false) {
        self.platform = platform
        self.addToNavController = addToNavController
        self.gameDetailsDelegate = gameDetailsDelegate
    }
}
