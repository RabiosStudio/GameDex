//
//  SelectAddGameTypeScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectAddGameMethodScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = SelectAddGameMethodViewModel()
        let layoutBuilder = BasicLayoutBuilder(
            cellSize: .big,
            cellHorizontalSpacing: .small,
            cellVerticalSpacing: .regular
        )
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layoutBuilder: layoutBuilder
        )
        let navigationController = UINavigationController(rootViewController: containerController)
        return navigationController
    }
}
