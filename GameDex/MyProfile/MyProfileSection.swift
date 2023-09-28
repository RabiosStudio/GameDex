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
                screenFactory: nil
            )
            self.cellsVM.append(logoutCellVM)
        } else {
            let loginCellVM = LabelCellViewModel(
                primaryText: L10n.login,
                screenFactory: LoginScreenFactory(myProfileDelegate: myProfileDelegate)
            )
            self.cellsVM.append(loginCellVM)
        }
        
        let collectionManagementCellVM = LabelCellViewModel(
            primaryText: L10n.collectionManagement,
            screenFactory: nil
        )
        self.cellsVM.append(collectionManagementCellVM)
        
        let contactUsCellVM = LabelCellViewModel(
            primaryText: L10n.contactUs,
            screenFactory: nil
        )
        self.cellsVM.append(contactUsCellVM)
    }
}
