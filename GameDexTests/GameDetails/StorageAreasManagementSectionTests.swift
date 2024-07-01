//
//  StorageAreasManagementSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/06/2024.
//

import XCTest
@testable import GameDex

final class StorageAreasManagementSectionTests: XCTestCase {
    
    private let sortedStorageAreas = MockData.storageAreas.sorted {
        $0.lowercased() < $1.lowercased()
    }
    
    func test_init_GivenNoContext_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = StorageAreasManagementSection(
            storageAreas: MockData.storageAreas,
            context: nil,
            formDelegate: FormDelegateMock(),
            storageAreaManagementDelegate: StorageAreasManagementDelegateMock()
        )
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.storageAreas.count)
        
        for (index, _) in MockData.storageAreas.enumerated() {
            guard let cellVM = section.cellsVM[index] as? LabelCellViewModel else {
                XCTFail("Wrong type")
                return
            }
            XCTAssertEqual(cellVM.text, self.sortedStorageAreas[index])
            XCTAssertTrue(cellVM.isEditable)
            XCTAssertTrue(cellVM.isDeletable)
        }
    }
    
    func test_init_GivenContextAdd_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = StorageAreasManagementSection(
            storageAreas: MockData.storageAreas,
            context: .add,
            formDelegate: FormDelegateMock(),
            storageAreaManagementDelegate: StorageAreasManagementDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.storageAreas.count + 1)
        
        guard let textFieldCellVM = section.cellsVM.first as? TextFieldCellViewModel else {
            XCTFail("Wrong type")
            return
        }
        guard let labelCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (LabelCellViewModel)
        }) as? [LabelCellViewModel] else {
            return
        }
        
        for (index, _) in self.sortedStorageAreas.enumerated() {
            let labelCellVM = labelCellsVM[index]
            XCTAssertEqual(labelCellVM.text, self.sortedStorageAreas[index])
            XCTAssertTrue(labelCellVM.isEditable)
            XCTAssertTrue(labelCellVM.isDeletable)
        }
        
        XCTAssertEqual(textFieldCellVM.placeholder, L10n.newStorageArea)
        XCTAssertEqual(textFieldCellVM.formType as? GameFormType, GameFormType.storageArea)
        XCTAssertNil(textFieldCellVM.value)
        XCTAssertTrue(textFieldCellVM.isEditable)
        XCTAssertTrue(textFieldCellVM.isFirstResponder)
        XCTAssertNil(textFieldCellVM.cellTappedCallback)
    }
    
    func test_init_GivenContextEdit_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = StorageAreasManagementSection(
            storageAreas: MockData.storageAreas,
            context: .edit(storageArea: MockData.storageAreas[1]),
            formDelegate: FormDelegateMock(),
            storageAreaManagementDelegate: StorageAreasManagementDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.storageAreas.count)
        
        guard let textFieldsCellVM = section.cellsVM.filter({ cellVM in
            return cellVM is (TextFieldCellViewModel)
        }) as? [TextFieldCellViewModel] else {
            return
        }
        guard let labelCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (LabelCellViewModel)
        }) as? [LabelCellViewModel] else {
            return
        }
        
        let nonEditingStorageAreas = self.sortedStorageAreas.filter { storageArea in
            storageArea == MockData.storageAreas[0] || storageArea == MockData.storageAreas[2]
        }
        let editingStorageArea = self.sortedStorageAreas.filter { storageArea in
            storageArea == MockData.storageAreas[1]
        }
        for (index, _) in nonEditingStorageAreas.enumerated() {
            let labelCellVM = labelCellsVM[index]
            XCTAssertEqual(labelCellVM.text, nonEditingStorageAreas[index])
            XCTAssertTrue(labelCellVM.isEditable)
            XCTAssertTrue(labelCellVM.isDeletable)
        }
        
        for storageArea in editingStorageArea {
            guard let textFieldCellVM = textFieldsCellVM.first else {
                XCTFail("Error no textfields")
                return
            }
            XCTAssertEqual(textFieldsCellVM.count, 1)
            XCTAssertEqual(textFieldCellVM.placeholder, L10n.newStorageArea)
            XCTAssertEqual(textFieldCellVM.formType as? GameFormType, GameFormType.storageArea)
            XCTAssertEqual(textFieldCellVM.value, storageArea)
            XCTAssertTrue(textFieldCellVM.isEditable)
            XCTAssertTrue(textFieldCellVM.isFirstResponder)
            XCTAssertNil(textFieldCellVM.cellTappedCallback)
        }
    }
}
