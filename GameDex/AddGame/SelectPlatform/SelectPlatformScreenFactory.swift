//
//  SelectPlatformScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectPlatformScreenFactory: ScreenFactory {
    
    weak var delegate: AddGameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = SelectPlatformViewModel(
            networkingSession: AlamofireAPI(),
            addGameDelegate: self.delegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    init(delegate: AddGameDetailsViewModelDelegate?) {
        self.delegate = delegate
    }
    
}
