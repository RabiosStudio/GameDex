//
//  MyCollectionFiltersScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/05/2024.
//

import Foundation
import UIKit

struct MyCollectionFiltersScreenFactory: ScreenFactory {
    var viewController: UIViewController {
        let viewModel = MyCollectionFiltersViewModel()
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
}
