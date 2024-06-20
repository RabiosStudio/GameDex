//
//  StorageAreaManagementScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

struct StorageAreaManagementScreenFactory: ScreenFactory {
    
    private let storageAreas: [String]
    
    var viewController: UIViewController {
        let viewModel = StorageAreaManagementViewModel(
            storageAreas: self.storageAreas,
            alertDisplayer: AlertDisplayerImpl()
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(storageAreas: [String]) {
        self.storageAreas = storageAreas
    }
}
