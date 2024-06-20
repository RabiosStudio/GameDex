//
//  StorageAreasManagementScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

struct StorageAreasManagementScreenFactory: ScreenFactory {
    
    private let storageAreas: [String]
    private weak var formDelegate: FormDelegate?
    
    var viewController: UIViewController {
        let viewModel = StorageAreasManagementViewModel(
            storageAreas: self.storageAreas,
            alertDisplayer: AlertDisplayerImpl(), 
            formDelegate: self.formDelegate
        )
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }

    init(
        storageAreas: [String],
        formDelegate: FormDelegate?
    ) {
        self.storageAreas = storageAreas
        self.formDelegate = formDelegate
    }
}
