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
    func addNewEntity()
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
    private var selectedStorageArea: String?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    weak var formDelegate: FormDelegate?
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    init(
        localDatabase: LocalDatabase,
        authenticationService: AuthenticationService,
        alertDisplayer: AlertDisplayer,
        formDelegate: FormDelegate?,
        gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        self.screenTitle = L10n.selectStorageArea
        self.buttonItems = [.add]
        self.storageAreas = []
        self.localDatabase = localDatabase
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.formDelegate = formDelegate
        self.gameDetailsDelegate = gameDetailsDelegate
        self.context = nil
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard let userId = self.authenticationService.getUserId() else {
            let storageAreaFetched = self.localDatabase.fetchAllStorageAreas()
            switch storageAreaFetched {
            case let .success(storageAreas):
                guard !storageAreas.isEmpty else {
                    callback(StorageAreaManagementError.emptyStorageAreas(delegate: self))
                    return
                }
                self.storageAreas = storageAreas
                self.updateSections(with: self.storageAreas, context: self.context)
                callback(nil)
            case .failure:
                callback(StorageAreaManagementError.fetchError)
            }
            return
        }
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .add:
            self.addNewStorageArea()
        default:
            break
        }
    }
}

extension StorageAreasManagementViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        guard let storageAreaToRemove = self.selectedStorageArea else {
            return
        }
        guard let userId = self.authenticationService.getUserId() else {
            guard await self.localDatabase.remove(storageArea: storageAreaToRemove) == nil else {
                self.displayAlert(success: false)
                return
            }
            for (index, item) in self.storageAreas.enumerated() {
                if storageAreaToRemove == item {
                    self.storageAreas.remove(at: index)
                }
            }
            await self.gameDetailsDelegate?.removeStorageAreaFromGameFormIfNeeded(storageArea: storageAreaToRemove)
            self.handleSuccess()
            return
        }
    }
}

private extension StorageAreasManagementViewModel {
    func addNewStorageArea() {
        self.context = .add
        self.updateSections(with: self.storageAreas, context: self.context)
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
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
    
    func displayAlert(success: Bool) {
        var alertText: String
        switch self.context {
        case .add:
            alertText = success ? L10n.successSavingStorageArea : L10n.errorSavingStorageArea
        case .edit:
            alertText = success ? L10n.successUpdatingStorageArea : L10n.errorUpdatingStorageArea
        case .delete:
            alertText = success ? L10n.successDeletingStorageArea : L10n.errorDeletingStorageArea
        default:
            return
        }
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: alertText
            )
        )
    }
    
    func handleSuccess() {
        self.displayAlert(success: true)
        self.context = nil
        self.updateSections(with: self.storageAreas, context: self.context)
        self.containerDelegate?.reloadData()
    }
}

extension StorageAreasManagementViewModel: StorageAreasManagementDelegate {
    func addNewEntity() {
        self.addNewStorageArea()
    }
    
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
        guard let value = value as? String else {
            return
        }
        self.context = .delete
        self.selectedStorageArea = value
        self.presentAlertBeforeDeletingStorageArea()
    }
    
    func select(storageArea: String) {
        self.formDelegate?.didUpdate(value: storageArea, for: GameFormType.storageArea)
        self.formDelegate?.refreshSections()
        self.containerDelegate?.goBackToPreviousScreen()
    }
}

extension StorageAreasManagementViewModel: FormDelegate {
    func confirmChanges(value: Any, for type: any FormType) async {
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
                guard await self.localDatabase.replaceStorageArea(oldValue: oldValue, newValue: value) == nil else {
                    self.displayAlert(success: false)
                    return
                }
                for (index, item) in self.storageAreas.enumerated() {
                    if oldValue == item {
                        self.storageAreas.remove(at: index)
                        self.storageAreas.insert(value, at: index)
                    }
                }
                await self.gameDetailsDelegate?.editStorageAreaFromGameFormIfNeeded(storageArea: value)
                self.handleSuccess()
            case .add:
                guard await self.localDatabase.add(storageArea: value) == nil else {
                    self.displayAlert(success: false)
                    return
                }
                self.storageAreas.append(value)
                self.handleSuccess()
            default:
                break
            }
        default:
            break
        }
    }
    
    func didUpdate(value: Any, for type: any FormType) {}
    
    func refreshSections() {}
}
