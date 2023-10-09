//
//  SelectAddGameTypeScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectAddGameMethodScreenFactory: ScreenFactory {
    
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = SelectAddGameMethodViewModel(delegate: self.myCollectionDelegate)
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        let navigationController = UINavigationController(rootViewController: containerController)
        return navigationController
    }
    
    init(delegate: MyCollectionViewModelDelegate?) {
        self.myCollectionDelegate = delegate
    }
}
