//
//  EditProfileScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/10/2023.
//

import Foundation
import UIKit

struct EditProfileScreenFactory: ScreenFactory {
    
    private let myProfileDelegate: MyProfileViewModelDelegate?
    private let myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = EditProfileViewModel(
            myProfileDelegate: self.myProfileDelegate,
            myCollectionDelegate: self.myCollectionDelegate,
            alertDisplayer: AlertDisplayerImpl(),
            authenticationService: AuthenticationServiceImpl(),
            cloudDatabase: FirestoreDatabase()
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
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
    }
}
