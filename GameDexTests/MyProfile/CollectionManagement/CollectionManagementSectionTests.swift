//
//  CollectionManagementSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 25/10/2023.
//

import XCTest
@testable import GameDex

final class CollectionManagementSectionTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = CollectionManagementSection(
            isLoggedIn: true,
            collection: MockData.platforms,
            alertDisplayer: AlertDisplayerMock(),
            primaryButtonDelegate: PrimaryButtonDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 3)
        
        guard let titleCellVM = section.cellsVM.first as? TitleCellViewModel,
              let collectionCellVM = section.cellsVM[1] as? TextFieldCellViewModel,
              let deleteCollectionButtonCellVM = section.cellsVM[2] as? PrimaryButtonCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(titleCellVM.title, L10n.selectAndDeleteACollection)
        XCTAssertEqual(deleteCollectionButtonCellVM.buttonViewModel, ButtonViewModel(isEnabled: true, buttonTitle: L10n.deleteFromCollection))
        XCTAssertEqual(deleteCollectionButtonCellVM.buttonType, .classic)
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any FormCellViewModel)
        }) as? [any FormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .collection(_):
                guard let collectionCellVMFormType = collectionCellVM.formType as? UserAccountFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(collectionCellVM.placeholder, L10n.collectionToDelete)
                
                var text = [String]()
                for item in MockData.platforms {
                    text.append(item.title)
                }
                XCTAssertEqual(
                    collectionCellVMFormType,
                    .collection(PickerViewModel(data: [text]))
                )
            case .email:
                return
            case .password:
                return
            }
        }
    }
}
