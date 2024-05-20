//
//  LoginViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class LoginViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.login
    var sections: [Section] = []
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myProfileDelegate: MyProfileViewModelDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [
            LoginSection(
                myProfileDelegate: self.myProfileDelegate,
                myCollectionDelegate: self.myCollectionDelegate,
                primaryButtonDelegate: self
            )
        ]
        callback(nil)
    }
    
}

// MARK: - PrimaryButtonDelegate
extension LoginViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let title else { return }
        let userHasAccount: Bool
        switch title {
        case L10n.login:
            userHasAccount = true
        default:
            userHasAccount = false
        }
        
        let screenFactory =  AuthenticationScreenFactory(
            userHasAccount: userHasAccount,
            myProfileDelegate: myProfileDelegate,
            myCollectionDelegate: myCollectionDelegate
        )
        Routing.shared.route(
            navigationStyle: .push(
                screenFactory: screenFactory
            )
        )
    }
}
