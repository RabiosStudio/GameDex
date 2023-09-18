//
//  SelectPlatformScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

struct SelectPlatformScreenFactory: ScreenFactory {
    
    weak var delegate: GameDetailsViewModelDelegate?
    
    var viewController: UIViewController {
        let viewModel = SelectPlatformViewModel(
            networkingSession: AlamofireAPI(),
            gameDetailsDelegate: self.delegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        return containerController
    }
    
    init(delegate: GameDetailsViewModelDelegate?) {
        self.delegate = delegate
    }
    
}
