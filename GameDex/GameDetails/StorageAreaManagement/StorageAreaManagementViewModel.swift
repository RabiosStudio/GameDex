//
//  StorageAreaManagementViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

final class StorageAreaManagementViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var isRefreshable: Bool = false
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]?
    let screenTitle: String?
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    private var storageAreas: [String]
    private var alertDisplayer: AlertDisplayer
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    
    init(
        storageAreas: [String],
        alertDisplayer: AlertDisplayer
    ) {
        self.screenTitle = L10n.selectStorageArea
        self.buttonItems = [.add]
        self.storageAreas = storageAreas
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.updateSections(with: self.storageAreas)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .add:
            print("add button tapped")
        default:
            break
        }
    }
}

extension StorageAreaManagementViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        print("OK button tapped in alert")
    }
}

private extension StorageAreaManagementViewModel {
    func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
    
    func updateSections(with storageAreas: [String]) {
        self.sections = [StorageAreaManagementSection(storageAreas: storageAreas)]
    }
    
    func presentAlertBeforeDeletingStorageArea() {
        self.alertDisplayer.presentBasicAlert(
            parameters: AlertViewModel(
                alertType: .warning,
                description: "Alert before deleting storage arez"
            )
        )
    }
}
