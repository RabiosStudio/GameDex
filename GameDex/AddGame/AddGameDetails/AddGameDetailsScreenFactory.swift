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
        let viewModel = AddGameDetailsViewModel(game: self.game)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
}
