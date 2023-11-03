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
        return containerController
    }
    
    private let platform: Platform
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(platform: Platform, myCollectionDelegate: MyCollectionViewModelDelegate?) {
        self.platform = platform
        self.myCollectionDelegate = myCollectionDelegate
    }
}
