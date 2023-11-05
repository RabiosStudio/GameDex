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
        myCollectionDelegate: MyCollectionViewModelDelegate?
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
            buttonViewModel: ButtonViewModel(buttonTitle: L10n.login),
            delegate: nil,
            cellTappedCallback: {
                let screenFactory =  AuthenticationScreenFactory(
                    userHasAccount: true,
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
        self.cellsVM.append(loginButtonCellVM)
        
        let signupButtonCellVM = PrimaryButtonCellViewModel(
            buttonViewModel: ButtonViewModel(buttonTitle: L10n.createAccount),
            delegate: nil,
            cellTappedCallback: {
                let screenFactory =  AuthenticationScreenFactory(
                    userHasAccount: false,
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
        
        self.cellsVM.append(signupButtonCellVM)
    }
}
