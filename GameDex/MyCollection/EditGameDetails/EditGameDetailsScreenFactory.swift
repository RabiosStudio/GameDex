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
    
    var viewController: UIViewController {
        let viewModel = EditGameDetailsViewModel(
            savedGame: self.savedGame,
            localDatabase: LocalDatabase(),
            alertDisplayer: AlertDisplayerImpl()
        )
        viewModel.alertDelegate = viewModel
        
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(savedGame: SavedGame) {
        self.savedGame = savedGame
    }
}
