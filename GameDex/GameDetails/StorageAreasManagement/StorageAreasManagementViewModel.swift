//
//  StorageAreasManagementViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

protocol StorageAreasManagementDelegate: ObjectManagementDelegate {
    func select(storageArea: String)
}

final class StorageAreasManagementViewModel: CollectionViewModel {
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
    weak var formDelegate: FormDelegate?
    
    init(
        storageAreas: [String],
        alertDisplayer: AlertDisplayer,
        formDelegate: FormDelegate?
    ) {
        self.screenTitle = L10n.selectStorageArea
        self.buttonItems = [.add]
        self.storageAreas = storageAreas
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.formDelegate = formDelegate
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

extension StorageAreasManagementViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        print("OK button tapped in alert")
    }
}

private extension StorageAreasManagementViewModel {
    func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
    
    func updateSections(with storageAreas: [String]) {
        self.sections = [StorageAreasManagementSection(
            storageAreas: storageAreas,
            storageAreaManagementDelegate: self
        )]
    }
    
    func presentAlertBeforeDeletingStorageArea() {
        self.alertDisplayer.presentBasicAlert(
            parameters: AlertViewModel(
                alertType: .warning,
                description: L10n.warningStorageAreaDeletion
            )
        )
    }
}

extension StorageAreasManagementViewModel: StorageAreasManagementDelegate {
    func select(storageArea: String) {
        self.formDelegate?.didUpdate(value: storageArea, for: GameFormType.storageArea)
        self.formDelegate?.refreshSections()
        self.containerDelegate?.goBackToPreviousScreen()
    }
    
    func edit() {
        print("edit button tapped")
    }
    
    func delete() {
        self.presentAlertBeforeDeletingStorageArea()
    }
}
