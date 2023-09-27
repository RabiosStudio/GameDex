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
    
    var viewController: UIViewController {
        let viewModel = AuthenticationViewModel(
            userHasAccount: self.userHasAccount,
            authenticationSerice: AuthenticationServiceImpl(),
            alertDisplayer: AlertDisplayerImpl(),
            myProfileDelegate: self.myProfileDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
    
    init(userHasAccount: Bool, myProfileDelegate: MyProfileViewModelDelegate?) {
        self.userHasAccount = userHasAccount
        self.myProfileDelegate = myProfileDelegate
    }
}
