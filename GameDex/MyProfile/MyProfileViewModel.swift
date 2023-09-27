//
//  MyProfileViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class MyProfileViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.myProfile
    var sections: [Section] = []
    var containerDelegate: ContainerViewControllerDelegate?
    
    init() {}
    private let authenticationService: AuthenticationService
    private var alertDisplayer: AlertDisplayer
    
    init(authenticationService: AuthenticationService, alertDisplayer: AlertDisplayer) {
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let isUserLoggedIn = self.authenticationService.isUserLoggedIn()
        self.sections = [
            MyProfileSection(
                userIsLoggedIn: isUserLoggedIn,
                completionBlock: { [weak self] in
                    
                    self?.alertDisplayer.presentBasicAlert(
                        parameters: AlertViewModel(
                            alertType: .warning,
                            description: L10n.warningLogOut,
                            cancelButtonTitle: L10n.cancel,
                            okButtonTitle: L10n.confirm
                        )
                    )
                }
            )
        ]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
}

extension MyProfileViewModel: AlertDisplayerDelegate {
    func didTapOkButton() {
    }
}
