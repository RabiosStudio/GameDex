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
    weak var addGameDelegate: AddGameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
            localDatabase: LocalDatabase(),
            addGameDelegate: self.addGameDelegate,
            alertDisplayer: AlertDisplayerImpl(alertDelegate: nil)
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(game: Game, addGameDelegate: AddGameDetailsViewModelDelegate?) {
        self.game = game
        self.addGameDelegate = addGameDelegate
    }
}
