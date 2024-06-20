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
    
    var viewController: UIViewController {
        let viewModel = StorageAreasManagementViewModel(
            localDatabase: LocalDatabaseImpl(),
            authenticationService: AuthenticationServiceImpl(),
            alertDisplayer: AlertDisplayerImpl(),
            formDelegate: self.formDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(formDelegate: FormDelegate?) {
        self.formDelegate = formDelegate
    }
}
