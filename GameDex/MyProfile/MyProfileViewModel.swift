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
    
    private let userIsLoggedIn: Bool
    
    init(authenticationService: AuthenticationService, alertDisplayer: AlertDisplayer) {
        self.authenticationService = authenticationService
        self.userIsLoggedIn = self.authenticationService.isUserLoggedIn()
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [
            MyProfileSection(
                userIsLoggedIn: self.userIsLoggedIn,
                myProfileDelegate: self,
                completionBlock: { [weak self] in
                    
                }
            )
        ]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
    
    func didSelectItem(indexPath: IndexPath) {
        self.alertDisplayer.presentBasicAlert(
            parameters: AlertViewModel(
                alertType: .warning,
                description: L10n.warningLogOut,
                cancelButtonTitle: L10n.cancel,
                okButtonTitle: L10n.confirm
            )
        )
    }
}

extension MyProfileViewModel: AlertDisplayerDelegate {
    func didTapOkButton() {
        self.authenticationService.logout(
            callback: { [weak self] error in
                if error != nil {
                    self?.alertDisplayer.presentTopFloatAlert(
                        parameters: AlertViewModel(
                            alertType: .error,
                            description: L10n.errorLogOutDescription
                        )
                    )
                } else {
                    self?.alertDisplayer.presentTopFloatAlert(
                        parameters: AlertViewModel(
                            alertType: .success,
                            description: L10n.successLogOutDescription
                        )
                    )
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
