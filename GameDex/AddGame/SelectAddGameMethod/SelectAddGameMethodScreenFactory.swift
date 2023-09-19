//
//  SelectAddGameTypeScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectAddGameMethodScreenFactory: ScreenFactory {
    
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = SelectAddGameMethodViewModel(delegate: self.gameDetailsDelegate)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        let navigationController = UINavigationController(rootViewController: containerController)
        return navigationController
    }
    
    init(delegate: GameDetailsViewModelDelegate?) {
        self.gameDetailsDelegate = delegate
    }
}
