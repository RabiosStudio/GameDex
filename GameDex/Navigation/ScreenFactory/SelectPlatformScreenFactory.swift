//
//  SelectPlatformScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectPlatformScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = SelectPlatformViewModel()
        let layoutBuilder = BasicLayoutBuilder(cellSize: .small)
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layoutBuilder: layoutBuilder
        )
        return containerController
    }
    
}
