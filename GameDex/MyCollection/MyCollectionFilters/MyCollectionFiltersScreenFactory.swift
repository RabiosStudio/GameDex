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
    
    var viewController: UIViewController {
        let viewModel = MyCollectionFiltersViewModel(games: self.games)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(games: [SavedGame]) {
        self.games = games
    }
}
