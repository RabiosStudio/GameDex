//
//  MyCollectionFiltersScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/05/2024.
//

import Foundation
import UIKit

struct MyCollectionFiltersScreenFactory: ScreenFactory {
    
    private let games: [SavedGame]
    private let gameFilterForm: GameFilterForm?
    private weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = MyCollectionFiltersViewModel(
            games: self.games,
            gameFilterForm: self.gameFilterForm ?? nil,
            myCollectionDelegate: self.myCollectionDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(
        games: [SavedGame],
        gameFilterForm: GameFilterForm?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.games = games
        self.gameFilterForm = gameFilterForm
        self.myCollectionDelegate = myCollectionDelegate
    }
}
