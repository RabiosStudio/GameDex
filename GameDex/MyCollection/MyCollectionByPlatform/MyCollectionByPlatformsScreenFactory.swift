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
    
    var viewController: UIViewController {
        let viewModel = MyCollectionByPlatformsViewModel(
            gamesCollection: self.gamesCollection,
            database: LocalDatabase(),
            alertDisplayer: AlertDisplayerImpl()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(gamesCollection: [SavedGame]) {
        self.gamesCollection = gamesCollection
    }
    
}
