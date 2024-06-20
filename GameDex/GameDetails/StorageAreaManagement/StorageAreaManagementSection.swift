//
//  StorageAreaManagementSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation

final class StorageAreaManagementSection: Section {
    
    init(
        storageAreas: [String],
        storageAreaManagementDelegate: StorageAreaManagementDelegate?
    ) {
        super.init()
        self.position = 0
        
        for storageArea in storageAreas {
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
