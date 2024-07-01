//
//  StorageAreasManagementScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

struct StorageAreasManagementScreenFactory: ScreenFactory {
    
    private weak var formDelegate: FormDelegate?
    private weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: LocalDatabaseImpl(),
            authenticationService: AuthenticationServiceImpl(),
            alertDisplayer: AlertDisplayerImpl(),
            formDelegate: self.formDelegate, 
            gameDetailsDelegate: self.gameDetailsDelegate
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
        formDelegate: FormDelegate?,
        gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        self.formDelegate = formDelegate
        self.gameDetailsDelegate = gameDetailsDelegate
    }
}
