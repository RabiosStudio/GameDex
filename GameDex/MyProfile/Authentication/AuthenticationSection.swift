//
//  AuthenticationSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

final class AuthenticationSection: Section {
    
    init(
        userHasAccount: Bool,
        primaryButtonDelegate: PrimaryButtonDelegate?,
        formDelegate: FormDelegate,
        completionBlock: (() -> Void)?
    ) {
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
            formType: UserAccountFormType.email,
            formDelegate: formDelegate
        )
        self.cellsVM.append(emailTextField)
        
        let passwordTextField = TextFieldCellViewModel(
            placeholder: L10n.password,
            formType: UserAccountFormType.password,
            formDelegate: formDelegate
        )
        self.cellsVM.append(passwordTextField)
        
        if userHasAccount {
            let forgotPasswordLabelCellVM = LabelCellViewModel(
                text: L10n.forgotPassword,
                cellTappedCallback: completionBlock
            )
            self.cellsVM.append(forgotPasswordLabelCellVM)
        }
    }
}
