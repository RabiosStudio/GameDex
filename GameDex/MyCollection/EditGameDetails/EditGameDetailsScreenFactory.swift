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
    private let platform: Platform
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = EditGameDetailsViewModel(
            savedGame: self.savedGame,
            platform: self.platform,
            localDatabase: LocalDatabaseImpl(),
            cloudDatabase: FirestoreDatabase(),
            alertDisplayer: AlertDisplayerImpl(),
            myCollectionDelegate: myCollectionDelegate,
            authenticationService: AuthenticationServiceImpl()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(savedGame: SavedGame, platform: Platform, myCollectionDelegate: MyCollectionViewModelDelegate?) {
        self.savedGame = savedGame
        self.platform = platform
        self.myCollectionDelegate = myCollectionDelegate
    }
}
