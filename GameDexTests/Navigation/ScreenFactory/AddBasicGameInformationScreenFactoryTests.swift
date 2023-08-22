//
//  AddBasicGameInformationScreenFactoryTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 22/08/2023.
//

import XCTest
@testable import GameDex

final class AddBasicGameInformationScreenFactoryTests: XCTestCase {
    
    func test_viewController_ShouldReturnCorrectValue() {
        // Given
        let screenFactory = AddBasicGameInformationScreenFactory()
        // When
        let viewController = screenFactory.viewController
        // Then
        guard let navController = viewController as? UINavigationController,
              let _ = navController.viewControllers.first as? ContainerViewController else {
            XCTFail("Wrong controllers passed")
            return
        }
    }
}
