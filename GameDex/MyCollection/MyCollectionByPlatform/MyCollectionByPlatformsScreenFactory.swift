//
//  MyCollectionByPlatformsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import UIKit

struct MyCollectionByPlatformsScreenFactory: ScreenFactory {
    
    private let platform: Platform
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: self.platform,
            database: LocalDatabase(),
            alertDisplayer: AlertDisplayerImpl(),
            gameDetailsDelegate: gameDetailsDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(platform: Platform, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.platform = platform
        self.gameDetailsDelegate = gameDetailsDelegate
    }
    
}
