//
//  CollectionManagementScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/10/2023.
//

import Foundation
import UIKit

struct CollectionManagementScreenFactory: ScreenFactory {
    
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = CollectionManagementViewModel(
            myCollectionDelegate: self.myCollectionDelegate,
            cloudDatabase: FirestoreDatabase(),
            localDatabase: LocalDatabaseImpl(),
            authenticationService: AuthenticationServiceImpl(),
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
    
    init(myCollectionDelegate: MyCollectionViewModelDelegate?) {
        self.myCollectionDelegate = myCollectionDelegate
    }
}
