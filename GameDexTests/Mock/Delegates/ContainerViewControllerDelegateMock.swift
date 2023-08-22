//
//  ContainerViewControllerDelegateMock.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation
@testable import GameDex

class ContainerViewControllerDelegateMock: ContainerViewControllerDelegate {
    var configureBottomViewCalled = false
    
    func configureBottomView(contentViewFactory: ContentViewFactory) {
        self.configureBottomViewCalled = true
    }
}
