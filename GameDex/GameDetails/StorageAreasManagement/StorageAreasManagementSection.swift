//
//  StorageAreasManagementSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation

final class StorageAreasManagementSection: Section {
    
    init(
        storageAreas: [String],
        context: StorageAreasManagementContext?,
        formDelegate: FormDelegate?,
        storageAreaManagementDelegate: StorageAreasManagementDelegate?
    ) {
        super.init()
        self.position = 0
        
        if context == .add {
            let newStorageAreaCellVM = TextFieldCellViewModel(
                placeholder: L10n.newStorageArea,
                formType: GameFormType.storageArea,
                value: nil,
                isEditable: true,
                formDelegate: formDelegate,
                cellTappedCallback: nil
            )
            self.cellsVM.append(newStorageAreaCellVM)
        }
        
        let sortedStorageAreas = storageAreas.sorted()
        for storageArea in sortedStorageAreas {
            let storageAreaCellVM = LabelCellViewModel(
                text: storageArea,
                isEditable: true,
                isDeletable: true,
                objectManagementDelegate: storageAreaManagementDelegate,
                cellTappedCallback: {
                    storageAreaManagementDelegate?.select(storageArea: storageArea)
                }
            )
            self.cellsVM.append(storageAreaCellVM)
        }
    }
}
