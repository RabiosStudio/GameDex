//
//  MyProfileSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class MyProfileSection: Section {
    
    init(
        userIsLoggedIn: Bool,
        myProfileDelegate: MyProfileViewModelDelegate?,
        completionBlock: (() -> Void)?
    ) {
        super.init()
        self.position = 0
        
        if userIsLoggedIn {
            let logoutCellVM = LabelCellViewModel(
                primaryText: L10n.logout,
                navigationStyle: .selectTab(
                    index: 1,
                    completionBlock: completionBlock
                )
            )
            self.cellsVM.append(logoutCellVM)
        } else {
            let loginCellVM = LabelCellViewModel(
                primaryText: L10n.login,
                navigationStyle: .push(
                    controller: LoginScreenFactory(
                        myProfileDelegate: myProfileDelegate
                    ).viewController
                )
            )
            self.cellsVM.append(loginCellVM)
        }
        
        let collectionManagementCellVM = LabelCellViewModel(
            primaryText: L10n.collectionManagement,
            navigationStyle: nil
        )
        self.cellsVM.append(collectionManagementCellVM)
        
        let contactUsCellVM = LabelCellViewModel(
            primaryText: L10n.contactUs,
            navigationStyle: nil
        )
        self.cellsVM.append(contactUsCellVM)
    }
}
