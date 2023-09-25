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
    
    var viewController: UIViewController {
        let viewModel = AuthenticationViewModel(userHasAccount: self.userHasAccount)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    init(userHasAccount: Bool) {
        self.userHasAccount = userHasAccount
    }
}
