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
        
        let sortedStorageAreas = storageAreas.sorted {
            $0.lowercased() < $1.lowercased()
        }
        
        switch context {
        case .add:
            let newStorageAreaCellVM = TextFieldCellViewModel(
                placeholder: L10n.newStorageArea,
                formType: GameFormType.storageArea,
                value: nil,
                isEditable: true,
                formDelegate: formDelegate,
                cellTappedCallback: nil
            )
            self.cellsVM.append(newStorageAreaCellVM)
            for storageArea in sortedStorageAreas {
                self.setupLabelCellViewModel(with: storageArea, storageAreaManagementDelegate: storageAreaManagementDelegate)
            }
        case .edit(storageArea: let value):
            for storageArea in sortedStorageAreas {
                if value == storageArea {
                    let editingStorageAreaCellVM = TextFieldCellViewModel(
                        placeholder: L10n.newStorageArea,
                        formType: GameFormType.storageArea,
                        value: value,
                        isEditable: true,
                        formDelegate: formDelegate,
                        cellTappedCallback: nil
                    )
                    self.cellsVM.append(editingStorageAreaCellVM)
                } else {
                    self.setupLabelCellViewModel(with: storageArea, storageAreaManagementDelegate: storageAreaManagementDelegate)
                }
            }
        default:
            for storageArea in sortedStorageAreas {
                self.setupLabelCellViewModel(with: storageArea, storageAreaManagementDelegate: storageAreaManagementDelegate)
            }
        }
    }
    
    func setupLabelCellViewModel(
        with storageArea: String,
        storageAreaManagementDelegate: StorageAreasManagementDelegate?
    ) {
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
