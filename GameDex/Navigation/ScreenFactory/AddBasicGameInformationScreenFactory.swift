//
//  AddBasicGameInformationScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

struct AddBasicGameInformationScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = AddBasicGameInformationViewModel()
        let layoutBuilder = FormLayoutBuilder()
        let containerController = ContainerViewController(viewModel: viewModel, layoutBuilder: layoutBuilder)
        viewModel.containerDelegate = containerController
        let navigationController = UINavigationController(rootViewController: containerController)
        return navigationController
    }
}
