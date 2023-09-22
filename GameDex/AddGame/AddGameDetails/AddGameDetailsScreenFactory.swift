//
//  AddGameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

struct AddGameDetailsScreenFactory: ScreenFactory {
    
    private let game: Game
    private let platform: Platform
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
            platform: self.platform,
            localDatabase: LocalDatabase(),
            gameDetailsDelegate: self.gameDetailsDelegate,
            alertDisplayer: AlertDisplayerImpl()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(game: Game, platform: Platform, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.game = game
        self.platform = platform
        self.gameDetailsDelegate = gameDetailsDelegate
    }
}
