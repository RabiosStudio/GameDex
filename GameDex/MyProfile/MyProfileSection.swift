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
        completionBlock: (() -> Void)?
    ) {
        super.init()
        self.position = 0
        
        if userIsLoggedIn {
            let loginCellVM = LabelCellViewModel(
                primaryText: L10n.logout,
                navigationStyle: .selectTab(
                    index: 1,
                    completionBlock: completionBlock
                )
            )
            self.cellsVM.append(loginCellVM)
        } else {
            let loginCellVM = LabelCellViewModel(
                primaryText: L10n.login,
                navigationStyle: .push(
                    controller: LoginScreenFactory(
                    ).viewController
                )
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
