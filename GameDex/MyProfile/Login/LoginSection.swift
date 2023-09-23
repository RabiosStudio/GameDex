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
        
        let headerCellVM = TitleCellViewModel(title: L10n.loginDescription)
        self.cellsVM.append(headerCellVM)
        
        let emailCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.emailAuth,
            title: L10n.loginEmail,
            screenFactory: nil
        )
        self.cellsVM.append(emailCellVM)
        
        let appleCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.appleAuth,
            title: L10n.loginApple,
            screenFactory: nil
        )
        self.cellsVM.append(appleCellVM)
        
        let facebookCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.facebookAuth,
            title: L10n.loginFacebook,
            screenFactory: nil
        )
        self.cellsVM.append(facebookCellVM)
        
        let googleCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.googleAuth,
            title: L10n.loginGoogle,
            screenFactory: nil
        )
        self.cellsVM.append(googleCellVM)
        
        let footerCellVM = TitleCellViewModel(title: L10n.noAccountYet)
        self.cellsVM.append(footerCellVM)
        
        let buttonCellVM = ButtonCellViewModel(title: L10n.createAccount)
        self.cellsVM.append(buttonCellVM)
    }
}
