//
//  LoginSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class LoginSection: Section {
    
    init(myProfileDelegate: MyProfileViewModelDelegate?) {
        super.init()
        self.position = 0
        
        let imageCellVM = ImageCellViewModel(imageName: Asset.devices.name)
        self.cellsVM.append(imageCellVM)
        
        let titleCellVM = TitleCellViewModel(
            title: L10n.loginDescription,
            size: .big
        )
        self.cellsVM.append(titleCellVM)
        
        let loginButtonCellVM = PrimaryButtonCellViewModel(
            title: L10n.login,
            delegate: nil,
            cellTappedCallback: {
                let screenFactory =  AuthenticationScreenFactory(
                    userHasAccount: true,
                    myProfileDelegate: myProfileDelegate
                )
                Routing.shared.route(
                    navigationStyle: .push(
                        controller: screenFactory.viewController
                    )
                )
            }
        )
        self.cellsVM.append(loginButtonCellVM)
        
        let signupButtonCellVM = PrimaryButtonCellViewModel(
            title: L10n.createAccount,
            delegate: nil,
            cellTappedCallback: {
                let screenFactory =  AuthenticationScreenFactory(
                    userHasAccount: false,
                    myProfileDelegate: myProfileDelegate
                )
                Routing.shared.route(
                    navigationStyle: .push(
                        controller: screenFactory.viewController
                    )
                )
            }
        )
        
        self.cellsVM.append(signupButtonCellVM)
    }
}
