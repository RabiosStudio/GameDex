//
//  LoginScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

struct LoginScreenFactory: ScreenFactory {
    
    private let myProfileDelegate: MyProfileViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = LoginViewModel(myProfileDelegate: self.myProfileDelegate)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    init(myProfileDelegate: MyProfileViewModelDelegate?) {
        self.myProfileDelegate = myProfileDelegate
    }
}
