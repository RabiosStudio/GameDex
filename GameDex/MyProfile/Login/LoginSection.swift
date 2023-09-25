//
//  LoginSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class LoginSection: Section {
    
    override init() {
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
            screenFactory: AuthenticationScreenFactory(userHasAccount: true)
        )
        self.cellsVM.append(loginButtonCellVM)
        
        let signupButtonCellVM = PrimaryButtonCellViewModel(
            title: L10n.createAccount,
            screenFactory: AuthenticationScreenFactory(userHasAccount: false)
        )
        self.cellsVM.append(signupButtonCellVM)
    }
}
