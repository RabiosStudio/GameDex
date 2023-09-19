//
//  PrimaryButtonContentViewFactoryTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 22/08/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class PrimaryButtonContentViewFactoryTests: XCTestCase {
    
    func test_init_GivenDelegate_ThenShouldSetDelegateCorrectly() {
        // Given
        let delegateMock = PrimaryButtonDelegateMock()
        // When
        let viewFactory = PrimaryButtonContentViewFactory(
            delegate: delegateMock,
            buttonTitle: "Button title",
            shouldEnable: true
        )
        
        // Then
        guard viewFactory.delegate is PrimaryButtonDelegateMock else {
            XCTFail("Delegate is not correct")
            return
        }
    }
    
}
