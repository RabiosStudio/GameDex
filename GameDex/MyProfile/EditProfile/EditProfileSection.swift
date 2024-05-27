//
//  EditProfileSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/10/2023.
//

import Foundation

final class EditProfileSection: Section {
    
    init(
        credentialsConfirmed: Bool,
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        alertDisplayer: AlertDisplayer,
        primaryButtonDelegate: PrimaryButtonDelegate?
    ) {
        super.init()
        self.position = 0
        
        let titleCellVM = TitleCellViewModel(
            title: credentialsConfirmed ? L10n.updateCredentials : L10n.confirmCredentials,
            size: .regular
        )
        self.cellsVM.append(titleCellVM)
        
        let emailTextFieldCellVM = TextFieldCellViewModel(
            placeholder: credentialsConfirmed ? L10n.newEmail : L10n.currentEmail,
            formType: UserAccountFormType.email
        )
        self.cellsVM.append(emailTextFieldCellVM)
        
        let passwordTextFieldCellVM = TextFieldCellViewModel(
            placeholder: credentialsConfirmed ? L10n.newPassword : L10n.currentPassword,
            formType: UserAccountFormType.password
        )
        self.cellsVM.append(passwordTextFieldCellVM)
        
        let updateProfileButtonCellVM = PrimaryButtonCellViewModel(
            buttonViewModel: ButtonViewModel(
                buttonTitle: credentialsConfirmed ? L10n.saveChanges : L10n.confirm,
                buttonBackgroundColor: .secondaryColor
            ),
            delegate: primaryButtonDelegate
        )
        self.cellsVM.append(updateProfileButtonCellVM)
        
        if credentialsConfirmed {
            let deleteProfileButtonCellVM = PrimaryButtonCellViewModel(
                buttonViewModel: ButtonViewModel(
                    buttonTitle: L10n.deleteAccount,
                    buttonBackgroundColor: .primaryColor
                ),
                delegate: primaryButtonDelegate,
                buttonType: .warning
            )
            self.cellsVM.append(deleteProfileButtonCellVM)
        }
    }
}
