//
//  CollectionManagementSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/10/2023.
//

import Foundation
import UIKit

final class CollectionManagementSection: Section {
    init(
        isLoggedIn: Bool,
        collection: [Platform]?,
        alertDisplayer: AlertDisplayer,
        primaryButtonDelegate: PrimaryButtonDelegate?
    ) {
        super.init()
        self.position = 0
        
        let titleCellVM = TitleCellViewModel(
            title: L10n.selectAndDeleteACollection,
            size: .small
        )
        self.cellsVM.append(titleCellVM)
        
        var text = [String]()
        if let collection {
            for item in collection {
                text.append(item.title)
            }
        }
        
        let collectionCellVM = TextFieldCellViewModel(
            placeholder: L10n.collectionToDelete,
            formType: UserAccountFormType.collection(
                PickerViewModel(
                    data: [text]
                )
            )
        )
        self.cellsVM.append(collectionCellVM)
        
        let deleteCollectionButtonCellVM = PrimaryButtonCellViewModel(
            buttonViewModel: ButtonViewModel(
                buttonTitle: L10n.deleteFromCollection,
                buttonBackgroundColor: .primaryColor
            ),
            delegate: primaryButtonDelegate,
            buttonType: .classic            
        )
        self.cellsVM.append(deleteCollectionButtonCellVM)
    }
}
