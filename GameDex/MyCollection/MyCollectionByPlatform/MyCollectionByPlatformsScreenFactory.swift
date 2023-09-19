//
//  MyCollectionByPlatformsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import UIKit

struct MyCollectionByPlatformsScreenFactory: ScreenFactory {
    
    private let gamesCollection: [SavedGame]
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: self.gamesCollection,
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
    
    init(gamesCollection: [SavedGame], gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.gamesCollection = gamesCollection
        self.gameDetailsDelegate = gameDetailsDelegate
    }
    
}
