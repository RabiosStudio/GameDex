//
//  ConnectivityDisplayerViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 08/10/2023.
//

import Foundation

protocol ConnectivityDisplayerViewModel: CollectionViewModel {
    var authenticationService: AuthenticationService { get }
    var connectivityChecker: ConnectivityChecker { get }
    
    func displayInfoWarningIfNeeded()
    func setupInfoWarning(text: String)
}

extension ConnectivityDisplayerViewModel {
    func displayInfoWarningIfNeeded() {
        if !self.authenticationService.isUserLoggedIn() && self.connectivityChecker.hasConnectivity() {
            self.setupInfoWarning(text: L10n.infoLogout)
        } else if !self.connectivityChecker.hasConnectivity() {
            self.setupInfoWarning(text: L10n.infoNoInternet)
        }
    }
    
    func setupInfoWarning(text: String) {
        self.containerDelegate?.configureSupplementaryView(
            contentViewFactory: InfoContentViewFactory(
                infoText: text,
                position: .top
            )
        )
    }
}
