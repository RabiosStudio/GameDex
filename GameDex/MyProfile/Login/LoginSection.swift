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
        
        let emailCellVM = SmallCardCellViewModel(
            cardType: .emailAuth,
            title: L10n.loginEmail
        )
        self.cellsVM.append(emailCellVM)
        
        let appleCellVM = SmallCardCellViewModel(
            cardType: .appleAuth,
            title: L10n.loginApple
        )
        self.cellsVM.append(appleCellVM)
        
        let facebookCellVM = SmallCardCellViewModel(
            cardType: .facebookAuth,
            title: L10n.loginFacebook
        )
        self.cellsVM.append(facebookCellVM)
        
        let googleCellVM = SmallCardCellViewModel(
            cardType: .googleAuth,
            title: L10n.loginGoogle
        )
        self.cellsVM.append(googleCellVM)
        
        let footerCellVM = TitleCellViewModel(title: L10n.noAccountYet)
        self.cellsVM.append(footerCellVM)
        
        let buttonCellVM = ButtonCellViewModel(title: L10n.createAccount)
        self.cellsVM.append(buttonCellVM)
    }
}
