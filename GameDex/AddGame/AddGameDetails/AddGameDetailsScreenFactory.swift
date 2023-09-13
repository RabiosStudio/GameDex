//
//  AddGameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

struct AddGameDetailsScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = AddGameDetailsViewModel(
            game: self.game,
            localDatabase: LocalDatabase()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
}
