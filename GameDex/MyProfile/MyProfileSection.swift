//
//  MyProfileSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class MyProfileSection: Section {
    
    init(
        isUserLoggedIn: Bool,
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        alertDisplayer: AlertDisplayer,
        appLauncher: AppLauncher
    ) {
        super.init()
        self.position = 0
        
        if isUserLoggedIn {
            let logoutCellVM = LabelCellViewModel(
                text: L10n.logout,
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
            
            let editMyProfileCellVM = LabelCellViewModel(
                text: L10n.editProfile,
                cellTappedCallback: {
                    let screenFactory = EditProfileScreenFactory(
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
            self.cellsVM.append(editMyProfileCellVM)
        } else {
            let loginCellVM = LabelCellViewModel(
                text: L10n.login,
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
            text: L10n.collectionManagement,
            cellTappedCallback: {
                let screenFactory = CollectionManagementScreenFactory(
                    myCollectionDelegate: myCollectionDelegate
                )
                Routing.shared.route(
                    navigationStyle: .push(
                        screenFactory: screenFactory
                    )
                )
            }
        )
        self.cellsVM.append(collectionManagementCellVM)
        
        let contactUsCellVM = LabelCellViewModel(
            text: L10n.contactUs,
            cellTappedCallback: {
                let email = "gabrielledalbera@icloud.com"
                let alertVM = AlertViewModel(
                    alertType: .error,
                    description: L10n.errorEmailAppDescription + email
                )
                
                guard let url = appLauncher.createEmailUrl(to: email) else {
                    alertDisplayer.presentTopFloatAlert(parameters: alertVM)
                    return
                }
                let urlEntry: NavigationStyle = .url(
                    appURL: url,
                    appLauncher: appLauncher,
                    alertDisplayer: alertDisplayer,
                    alertViewModel: alertVM
                )
                Routing.shared.route(
                    navigationStyle: urlEntry,
                    fromController: nil,
                    animated: false
                )
            }
        )
        self.cellsVM.append(contactUsCellVM)
    }
}
