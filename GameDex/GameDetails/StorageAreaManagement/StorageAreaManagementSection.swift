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
        objectManagementDelegate: ObjectManagementDelegate?
    ) {
        super.init()
        self.position = 0
        
        for storageArea in storageAreas {
            let storageAreaCellVM = LabelCellViewModel(
                text: storageArea,
                isEditable: true,
                isDeletable: true,
                objectManagementDelegate: objectManagementDelegate,
                cellTappedCallback: {
                    print("cell tapped : \(storageArea)")
                }
            )
            self.cellsVM.append(storageAreaCellVM)
        }
    }
}
