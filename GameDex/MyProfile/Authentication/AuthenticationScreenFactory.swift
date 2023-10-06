//
//  AuthenticationScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

struct AuthenticationScreenFactory: ScreenFactory {
    
    private let userHasAccount: Bool
    private let myProfileDelegate: MyProfileViewModelDelegate?
    private let myCollectionDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = AuthenticationViewModel(
            userHasAccount: self.userHasAccount,
            authenticationSerice: AuthenticationServiceImpl(),
            alertDisplayer: AlertDisplayerImpl(),
            myProfileDelegate: self.myProfileDelegate,
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
    
    init(userHasAccount: Bool,
         myProfileDelegate: MyProfileViewModelDelegate?,
         myCollectionDelegate: GameDetailsViewModelDelegate?
    ) {
        self.userHasAccount = userHasAccount
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
    }
}
