//
//  CollectionManagementViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/10/2023.
//

import Foundation

final class CollectionManagementViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.collectionManagement
    var sections: [Section] = []
    
    var isLoggedIn: Bool = false
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myProfileDelegate: MyProfileViewModelDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let cloudDatabase: CloudDatabase
    private let localDatabase: LocalDatabase
    private let authenticationService: AuthenticationService
    private var alertDisplayer: AlertDisplayer
    
    private var collection: [Platform]
    
    init(
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        cloudDatabase: CloudDatabase,
        localDatabase: LocalDatabase,
        authenticationService: AuthenticationService,
        alertDisplayer: AlertDisplayer
    ) {
        self.myCollectionDelegate = myCollectionDelegate
        self.cloudDatabase = cloudDatabase
        self.localDatabase = localDatabase
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.collection = []
        self.alertDisplayer.alertDelegate = self
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) async {
        guard let userId = authenticationService.getUserId() else {
            let fetchPlatformsResult = self.localDatabase.fetchAllPlatforms()
            switch fetchPlatformsResult {
            case .success(let platforms):
                guard !platforms.isEmpty else {
                    callback(MyCollectionError.noItems)
                    return
                }
                let convertedPlatforms = CoreDataConverter.convert(platformsCollected: platforms)
                self.collection = convertedPlatforms.sorted {
                    $0.title < $1.title
                }
                self.isLoggedIn = false
                self.handleSectionCreation()
                callback(nil)
            case .failure:
                callback(MyCollectionError.fetchError)
            }
            return
        }
        let fetchPlatformsResult = await self.cloudDatabase.getUserCollection(userId: userId)
        switch fetchPlatformsResult {
        case .success(let platforms):
            guard !platforms.isEmpty else {
                callback(MyCollectionError.noItems)
                return
            }
            self.collection = platforms.sorted {
                $0.title < $1.title
            }
            self.isLoggedIn = true
            self.handleSectionCreation()
            callback(nil)
        case .failure:
            callback(MyCollectionError.fetchError)
        }
        return
    }
    
    private func handleSectionCreation() {
        self.sections = [
            CollectionManagementSection(
                isLoggedIn: self.isLoggedIn,
                collection: self.collection,
                alertDisplayer: self.alertDisplayer,
                primaryButtonDelegate: self
            )
        ]
    }
    
    private func displayAlert(success: Bool, platformTitle: String) {
        let text = success ? "\(platformTitle)" + L10n.successDeletePlatformDescription : L10n.removeGameErrorDescription
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: text
            )
        )
    }
    
    private func getPlatformToDelete() -> Platform? {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any CollectionFormCellViewModel)
              }) as? [any CollectionFormCellViewModel] else {
            return nil
        }
        
        var platformTitle: String?
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return nil }
            switch formType {
            case .collection:
                platformTitle = formCellVM.value as? String
            default:
                break
            }
        }
        
        let platformToDelete = self.collection.first { aPlatform in
            aPlatform.title == platformTitle
        }
        
        return platformToDelete
    }
}

extension CollectionManagementViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        guard let platformToDelete = self.getPlatformToDelete() else {
            return
        }
        guard let userId = authenticationService.getUserId() else {
            guard await self.localDatabase.remove(platform: platformToDelete) == nil else {
                self.displayAlert(success: false, platformTitle: platformToDelete.title)
                return
            }
            self.displayAlert(success: true, platformTitle: platformToDelete.title)
            await self.myCollectionDelegate?.reloadCollection()
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        
        guard await self.cloudDatabase.removePlatformAndGames(userId: userId, platform: platformToDelete) == nil else {
            self.displayAlert(success: false, platformTitle: platformToDelete.title)
            return
        }
        self.displayAlert(success: true, platformTitle: platformToDelete.title)
        await self.myCollectionDelegate?.reloadCollection()
        self.containerDelegate?.goBackToRootViewController()
    }
}

extension CollectionManagementViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let title else { return }
        switch title {
        case L10n.deleteFromCollection:
            alertDisplayer.presentBasicAlert(
                parameters: AlertViewModel(
                    alertType: .warning,
                    description: isLoggedIn ? L10n.warningPlatformDeletionCloud : L10n.warningPlatformDeletionLocal
                )
            )
        default:
            return
        }        
    }
}
