//
//  MyCollectionByPlatformsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import UIKit

struct MyCollectionByPlatformsScreenFactory: ScreenFactory {
    
    private let platform: Platform
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = MyCollectionByPlatformsViewModel(
            platform: self.platform,
            localDatabase: LocalDatabaseImpl(),
            cloudDatabase: FirestoreDatabase(),
            alertDisplayer: AlertDisplayerImpl(),
            myCollectionDelegate: myCollectionDelegate,
            authenticationService: AuthenticationServiceImpl(),
            connectivityChecker: ConnectivityCheckerImpl()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(platform: Platform, myCollectionDelegate: MyCollectionViewModelDelegate?) {
        self.platform = platform
        self.myCollectionDelegate = myCollectionDelegate
    }
    
}
