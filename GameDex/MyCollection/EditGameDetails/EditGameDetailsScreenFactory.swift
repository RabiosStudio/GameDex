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
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = EditGameDetailsViewModel(
            savedGame: self.savedGame,
            platformName: self.platformName,
            localDatabase: LocalDatabaseImpl(),
            alertDisplayer: AlertDisplayerImpl(),
            myCollectionDelegate: myCollectionDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(savedGame: SavedGame, platformName: String, myCollectionDelegate: MyCollectionViewModelDelegate?) {
        self.savedGame = savedGame
        self.platformName = platformName
        self.myCollectionDelegate = myCollectionDelegate
    }
}
