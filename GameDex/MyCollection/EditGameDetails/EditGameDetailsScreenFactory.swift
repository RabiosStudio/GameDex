//
//  EditGameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
import UIKit

struct EditGameDetailsScreenFactory: ScreenFactory {
    
    private let savedGame: SavedGame
    private let platformName: String
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = EditGameDetailsViewModel(
            savedGame: self.savedGame,
            platformName: self.platformName,
            localDatabase: LocalDatabaseImpl(),
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

    init(savedGame: SavedGame, platformName: String, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.savedGame = savedGame
        self.platformName = platformName
        self.gameDetailsDelegate = gameDetailsDelegate
    }
}
