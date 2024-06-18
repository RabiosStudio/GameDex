//
//  GameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 03/06/2024.
//

import Foundation
import UIKit

struct GameDetailsScreenFactory: ScreenFactory {
    
    private let gameDetailsContext: GameDetailsContext
    private let platform: Platform
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = GameDetailsViewModel(
            gameDetailsContext: self.gameDetailsContext,
            platform: self.platform,
            localDatabase: LocalDatabaseImpl(),
            cloudDatabase: FirestoreDatabase(),
            alertDisplayer: AlertDisplayerImpl(),
            myCollectionDelegate: self.myCollectionDelegate,
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

    init(
        gameDetailsContext: GameDetailsContext,
        platform: Platform,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.gameDetailsContext = gameDetailsContext
        self.platform = platform
        self.myCollectionDelegate = myCollectionDelegate
    }
}
