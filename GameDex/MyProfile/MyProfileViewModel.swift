//
//  MyProfileViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol MyProfileViewModelDelegate: AnyObject {
    func reloadMyProfile()
}

final class MyProfileViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.myProfile
    var sections: [Section] = []
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let authenticationService: AuthenticationService
    private var alertDisplayer: AlertDisplayer
    private let cloudDatabase: CloudDatabase
    private let localDatabase: LocalDatabase
    
    init(
        authenticationService: AuthenticationService,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        cloudDatabase: CloudDatabase,
        localDatabase: LocalDatabase
    ) {
        self.authenticationService = authenticationService
        self.cloudDatabase = cloudDatabase
        self.localDatabase = localDatabase
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let isUserLoggedIn = self.authenticationService.isUserLoggedIn()
        self.sections = [
            MyProfileSection(
                isUserLoggedIn: isUserLoggedIn,
                myProfileDelegate: self,
                myCollectionDelegate: self.myCollectionDelegate,
                alertDisplayer: self.alertDisplayer,
                appLauncher: AppLauncherImpl()
            )
        ]
        callback(nil)
    }
    
    private func displayLogOutAlert(success: Bool) {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: success ? L10n.successLogOutDescription : L10n.errorLogOutDescription
            )
        )
    }
    
    private func displaySyncDataError() {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .error,
                description: L10n.errorSyncCloudAndLocalDatabases
            )
        )
    }
}

extension MyProfileViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        if let userID = self.authenticationService.getUserId(),
           let _ = await self.cloudDatabase.syncLocalAndCloudDatabases(
            userId: userID,
            localDatabase: self.localDatabase
           ) {
            self.displaySyncDataError()
        }
        
        guard await self.authenticationService.logout() == nil else {
            self.displayLogOutAlert(success: false)
            return
        }
        self.displayLogOutAlert(success: true)
        await self.myCollectionDelegate?.reloadCollection()
        self.containerDelegate?.reloadData()
    }
}

extension MyProfileViewModel: MyProfileViewModelDelegate {
    func reloadMyProfile() {
        self.containerDelegate?.reloadData()
    }
}
