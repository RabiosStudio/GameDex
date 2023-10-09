//
//  SearchGameByTitleScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import UIKit

struct SearchGameByTitleScreenFactory: ScreenFactory {
    
    var viewController: UIViewController {
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: AlamofireAPI(),
            platform: self.platform,
            myCollectionDelegate: self.myCollectionDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        if self.addToNavController {
            let navigationController = UINavigationController(
                rootViewController: containerController
            )
            return navigationController
        } else {
            return containerController
        }
    }
    
    private let platform: Platform
    private let addToNavController: Bool
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(platform: Platform, myCollectionDelegate: MyCollectionViewModelDelegate?, addToNavController: Bool = false) {
        self.platform = platform
        self.addToNavController = addToNavController
        self.myCollectionDelegate = myCollectionDelegate
    }
}
