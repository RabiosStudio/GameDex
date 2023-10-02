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
    
    private let authenticationService: AuthenticationService
    private var alertDisplayer: AlertDisplayer
    
    init(authenticationService: AuthenticationService, alertDisplayer: AlertDisplayer) {
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let userIsLoggedIn = self.authenticationService.isUserLoggedIn()
        self.sections = [
            MyProfileSection(
                userIsLoggedIn: userIsLoggedIn,
                myProfileDelegate: self,
                alertDisplayer: self.alertDisplayer
            )
        ]
        callback(nil)
    }
}

extension MyProfileViewModel: AlertDisplayerDelegate {
    func didTapOkButton() {
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
    }
}

extension MyProfileViewModel: MyProfileViewModelDelegate {
    func reloadMyProfile() {
        self.containerDelegate?.reloadSections()
    }
}
