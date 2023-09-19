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
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = EditGameDetailsViewModel(
            savedGame: self.savedGame,
            localDatabase: LocalDatabase(),
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

    init(savedGame: SavedGame, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.savedGame = savedGame
        self.gameDetailsDelegate = gameDetailsDelegate
    }
}
