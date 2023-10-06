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
    private let myCollectionDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = LoginViewModel(
            myProfileDelegate: self.myProfileDelegate,
            myCollectionDelegate: self.myCollectionDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    init(
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: GameDetailsViewModelDelegate?
    ) {
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
    }
}
