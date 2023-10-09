//
//  MyProfileViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

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
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let authenticationService: AuthenticationService
    private var alertDisplayer: AlertDisplayer
    
    init(
        authenticationService: AuthenticationService,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.authenticationService = authenticationService
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
                alertDisplayer: self.alertDisplayer
            )
        ]
        callback(nil)
    }
}

extension MyProfileViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        self.authenticationService.logout(
            callback: { [weak self] error in
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: error == nil ? .success : .error,
                        description: error == nil ? L10n.successLogOutDescription : L10n.errorLogOutDescription
                    )
                )
                if error == nil {
                    self?.containerDelegate?.reloadSections()
                }
            }
        )
        await self.myCollectionDelegate?.reloadCollection()
    }
}

extension MyProfileViewModel: MyProfileViewModelDelegate {
    func reloadMyProfile() {
        self.containerDelegate?.reloadSections()
    }
}
