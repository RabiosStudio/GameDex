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
    private let selectedFilters: [GameFilter]?
    private weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = MyCollectionFiltersViewModel(
            games: self.games,
            selectedFilters: self.selectedFilters,
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
        selectedFilters: [GameFilter]?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.games = games
        self.selectedFilters = selectedFilters
        self.myCollectionDelegate = myCollectionDelegate
    }
}