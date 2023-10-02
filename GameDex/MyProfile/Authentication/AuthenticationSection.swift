//
//  AuthenticationSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

final class AuthenticationSection: Section {
    
    init(userHasAccount: Bool, primaryButtonDelegate: PrimaryButtonDelegate?) {
        super.init()
        self.position = 0
        
        let title = userHasAccount ? L10n.loginEmail : L10n.signupEmail
        let titleCellVM = TitleCellViewModel(
            title: title,
            size: .small
        )
        self.cellsVM.append(titleCellVM)
        
        let emailTextField = TextFieldCellViewModel(
            placeholder: L10n.email,
            formType: UserAccountFormType.email
        )
        self.cellsVM.append(emailTextField)
        
        let passwordTextField = TextFieldCellViewModel(
            placeholder: L10n.password,
            formType: UserAccountFormType.password
        )
        self.cellsVM.append(passwordTextField)
        
        let loginButtonCellVM = PrimaryButtonCellViewModel(
            title: userHasAccount ? L10n.login : L10n.createAccount,
            delegate: primaryButtonDelegate
        )
        self.cellsVM.append(loginButtonCellVM)
        
        let otherLoginMethodTitle = userHasAccount ? "\(L10n.or) \n \n \(L10n.login) \(L10n.authThroughOtherMethods)" : "\(L10n.or) \n \n \(L10n.signup) \(L10n.authThroughOtherMethods)"
        let otherLoginMethodTitleCellVM = TitleCellViewModel(
            title: otherLoginMethodTitle,
            size: .big
        )
        self.cellsVM.append(otherLoginMethodTitleCellVM)
        
        let appleCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.appleAuth,
            title: userHasAccount ? L10n.loginApple : L10n.signupApple
        )
        self.cellsVM.append(appleCellVM)
        
        let facebookCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.facebookAuth,
            title: userHasAccount ? L10n.loginFacebook : L10n.signupFacebook
        )
        self.cellsVM.append(facebookCellVM)
        
        let googleCellVM = BasicCardCellViewModel(
            cardType: AuthCardType.googleAuth,
            title: userHasAccount ? L10n.loginGoogle : L10n.signupGoogle
        )
        self.cellsVM.append(googleCellVM)
    }
}
