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
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        alertDisplayer: AlertDisplayer
    ) {
        super.init()
        self.position = 0
        
        if userIsLoggedIn {
            let logoutCellVM = LabelCellViewModel(
                primaryText: L10n.logout,
                cellTappedCallback: {
                    alertDisplayer.presentBasicAlert(
                        parameters: AlertViewModel(
                            alertType: .warning,
                            description: L10n.warningLogOut,
                            cancelButtonTitle: L10n.cancel,
                            okButtonTitle: L10n.confirm
                        )
                    )
                }
            )
            self.cellsVM.append(logoutCellVM)
        } else {
            let loginCellVM = LabelCellViewModel(
                primaryText: L10n.login,
                cellTappedCallback: {
                    let screenFactory = LoginScreenFactory(
                        myProfileDelegate: myProfileDelegate,
                        myCollectionDelegate: myCollectionDelegate
                    )
                    Routing.shared.route(
                        navigationStyle: .push(
                            screenFactory: screenFactory
                        )
                    )
                }
            )
            self.cellsVM.append(loginCellVM)
        }
        
        let collectionManagementCellVM = LabelCellViewModel(
            primaryText: L10n.collectionManagement
        )
        self.cellsVM.append(collectionManagementCellVM)
        
        let contactUsCellVM = LabelCellViewModel(
            primaryText: L10n.contactUs
        )
        self.cellsVM.append(contactUsCellVM)
    }
}
