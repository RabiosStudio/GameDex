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
        let viewModel = SelectPlatformViewModel(networkingSession: AlamofireAPI())
        let layoutBuilder = BasicLayoutBuilder(
            cellSize: .small,
            cellHorizontalSpacing: .small,
            cellVerticalSpacing: .none
        )
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layoutBuilder: layoutBuilder
        )
        return containerController
    }
    
}
