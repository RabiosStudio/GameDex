//
//  StorageAreasManagementViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation
import UIKit

// sourcery: AutoMockable
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
    private var context: StorageAreasManagementContext?
    private let localDatabase: LocalDatabase
    private let authenticationService: AuthenticationService
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    weak var formDelegate: FormDelegate?
    
    init(
        localDatabase: LocalDatabase,
        authenticationService: AuthenticationService,
        alertDisplayer: AlertDisplayer,
        formDelegate: FormDelegate?
    ) {
        self.screenTitle = L10n.selectStorageArea
        self.buttonItems = [.add]
        self.storageAreas = []
        self.localDatabase = localDatabase
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.formDelegate = formDelegate
        self.context = nil
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard let userId = self.authenticationService.getUserId() else {
            let storageAreaFetched = self.localDatabase.fetchAllStorageAreas()
            switch storageAreaFetched {
            case let .success(storageAreas):
                guard !storageAreas.isEmpty else {
                    callback(MyCollectionError.noItems(delegate: nil))
                    return
                }
                self.storageAreas = storageAreas
                self.updateSections(with: self.storageAreas, context: self.context)
                callback(nil)
            case .failure:
                callback(MyCollectionError.fetchError)
            }
            return
        }
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .add:
            self.context = .add
            self.updateSections(with: self.storageAreas, context: self.context)
            self.containerDelegate?.reloadSections(emptyError: nil)
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
    
    func updateSections(
        with storageAreas: [String],
        context: StorageAreasManagementContext?
    ) {
        self.sections = [StorageAreasManagementSection(
            storageAreas: storageAreas,
            context: context,
            formDelegate: self,
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
    func edit(value: Any) {
        guard let value = value as? String else {
            return
        }
        self.context = .edit(storageArea: value)
        self.updateSections(
            with: self.storageAreas,
            context: self.context
        )
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
    func delete(value: Any) {
        self.presentAlertBeforeDeletingStorageArea()
    }
    
    func select(storageArea: String) {
        self.formDelegate?.didUpdate(value: storageArea, for: GameFormType.storageArea)
        self.formDelegate?.refreshSections()
        self.containerDelegate?.goBackToPreviousScreen()
    }
}

extension StorageAreasManagementViewModel: FormDelegate {
    func confirmChanges(value: Any, for type: any FormType) {
        guard let formType = type as? GameFormType else {
            return
        }
        switch formType {
        case .storageArea:
            guard let value = value as? String else {
                return
            }
            switch self.context {
            case .edit(storageArea: let oldValue):
                for (index, item) in self.storageAreas.enumerated() {
                    if oldValue == item {
                        self.storageAreas.remove(at: index)
                        self.storageAreas.insert(value, at: index)
                    }
                }
            case .add:
                self.storageAreas.append(value)
            default:
                break
            }
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .success,
                    description: L10n.successSavingStorageArea
                )
            )
            self.context = nil
            self.updateSections(with: self.storageAreas, context: self.context)
            self.containerDelegate?.reloadSections(emptyError: nil)
        default:
            break
        }
    }
    
    func didUpdate(value: Any, for type: any FormType) {}
    
    func refreshSections() {}
}
