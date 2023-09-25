//
//  LoginScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

struct LoginScreenFactory: ScreenFactory {
    var viewController: UIViewController {
        let viewModel = LoginViewModel()
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
}