//
//  PrimaryButtonCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/11/2023.
//

import XCTest
@testable import GameDex

final class PrimaryButtonCellViewModelTests: XCTestCase {
    
    func test_didTap_ThenShouldCallDelegate() {
        // Given
        let delegate = PrimaryButtonDelegateMock()
        let viewModel = PrimaryButtonCellViewModel(buttonViewModel: ButtonViewModel(buttonTitle: "title"), delegate: delegate)
        
        // When
        viewModel.didTap(buttonTitle: "title") {
            delegate.verify(.didTapPrimaryButton(with: "title"))
        }
    }
}
//
//        
//        func didTap(buttonTitle: String?, completion: @escaping () -> ()) {
//            Task {
//                await delegate?.didTapPrimaryButton(with: buttonTitle)
//                completion()
//            }
//        }
//    }
