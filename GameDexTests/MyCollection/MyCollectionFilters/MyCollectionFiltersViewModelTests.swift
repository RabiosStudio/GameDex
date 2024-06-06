//
//  MyCollectionFiltersViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/05/2024.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class MyCollectionFiltersViewModelTests: XCTestCase {
    
    // MARK: Tests
    
    func test_init_ThenShouldCreateNoSectionsAndItems() {
        // Given
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: nil,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsAreSetCorrectlyAndContainerDelegateIsCalled() {
        // Given
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: nil,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.containerDelegate = containerDelegate
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 7)
        containerDelegate.verify(.configureSupplementaryView(contentViewFactory: .any), count: .once)
    }
    
    func test_didTapPrimaryButton_GivenNoFilter_ThenMyCollectionDelegateClearFiltersIsCalledAndViewIsDismissed() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: nil,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        myCollectionDelegate.verify(.clearFilters(), count: .once)
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_didTapPrimaryButton_GivenSelectedFilter_ThenMyCollectionDelegateApplyFiltersIsCalledAndViewIsDismissed() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: MockData.gameFilterForm,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        myCollectionDelegate.verify(.apply(filters: .any), count: .once)
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_didTapCloseButtonItem_ThenViewShouldBeDismissed() async {
        // Given
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: MockData.gameFilterForm,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTap(buttonItem: .close)
        
        // Then
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_didTapClearButtonItem_ThenDelegateClearFiltersIsCalled() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: MockData.gameFilterForm,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTap(buttonItem: .clear)
        
        // Then
        containerDelegate.verify(.configureSupplementaryView(contentViewFactory: .any), count: 2)
    }
    
    func test_didUpdate_ThenSetsGameFilterFormCorrectly() {
        // GIVEN
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            gameFilterForm: MockData.digitalGameFilterForm,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        
        // WHEN
        var acquisitionYearArea = [String]()
        for item in MockData.savedGames {
            if let data = item.acquisitionYear {
                acquisitionYearArea.append(data)
            }
        }
        viewModel.didUpdate(
            value: MockData.gameFilterForm.acquisitionYear as Any,
            for: GameFilterFormType.acquisitionYear(
                PickerViewModel(
                    data: [acquisitionYearArea]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.gameFilterForm.gameCondition as Any,
            for: GameFilterFormType.gameCondition(
                PickerViewModel(
                    data: [GameCondition.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.gameFilterForm.gameCompleteness as Any,
            for: GameFilterFormType.gameCompleteness(
                PickerViewModel(
                    data: [GameCompleteness.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            )
        )
        viewModel.didUpdate(
            value: MockData.gameFilterForm.gameRegion as Any,
            for: GameFilterFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            )
        )
        viewModel.didUpdate(value: MockData.gameFilterForm.rating as Any, for: GameFilterFormType.rating)
        
        var storageAreaArray = [String]()
        for item in MockData.savedGames {
            if let data = item.storageArea {
                storageAreaArray.append(data)
            }
        }
        viewModel.didUpdate(
            value: MockData.gameFilterForm.storageArea as Any,
            for: GameFilterFormType.storageArea(
                PickerViewModel(
                    data: [storageAreaArray]
                )
            )
        )
        
        let gameFormatArray = [L10n.physical, L10n.digital, L10n.any]
        viewModel.didUpdate(
            value: MockData.gameFilterForm.isPhysical as Any,
            for: GameFilterFormType.isPhysical(
                PickerViewModel(
                    data: [gameFormatArray]
                )
            )
        )
        
        // THEN
        XCTAssertEqual(viewModel.gameFilterForm.acquisitionYear, MockData.gameFilterForm.acquisitionYear)
        XCTAssertEqual(viewModel.gameFilterForm.gameCompleteness, MockData.gameFilterForm.gameCompleteness)
        XCTAssertEqual(viewModel.gameFilterForm.gameCondition, MockData.gameFilterForm.gameCondition)
        XCTAssertEqual(viewModel.gameFilterForm.gameRegion, MockData.gameFilterForm.gameRegion)
        XCTAssertEqual(viewModel.gameFilterForm.storageArea, MockData.gameFilterForm.storageArea)
        XCTAssertEqual(viewModel.gameFilterForm.rating, MockData.gameFilterForm.rating)
    }
}
