//
//  LoginSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class LoginSection: Section {
        
    init(
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        primaryButtonDelegate: PrimaryButtonDelegate?
    ) {
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
            buttonViewModel: ButtonViewModel(
                buttonTitle: L10n.login,
                buttonBackgroundColor: .secondaryColor
            ),
            delegate: primaryButtonDelegate
        )
        self.cellsVM.append(loginButtonCellVM)
        
        let signupButtonCellVM = PrimaryButtonCellViewModel(
            buttonViewModel: ButtonViewModel(
                buttonTitle: L10n.createAccount,
                buttonBackgroundColor: .secondaryColor
            ),
            delegate: primaryButtonDelegate
        )
        
        self.cellsVM.append(signupButtonCellVM)
    }
}
