//
//  AuthenticationViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

final class AuthenticationViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String?
    var sections: [Section] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let userHasAccount: Bool
    private let authenticationSerice: AuthenticationService
    private let alertDisplayer: AlertDisplayer
    
    init(
        userHasAccount: Bool,
        authenticationSerice: AuthenticationService,
        alertDisplayer: AlertDisplayer
    ) {
        self.userHasAccount = userHasAccount
        self.authenticationSerice = authenticationSerice
        self.alertDisplayer = alertDisplayer
        self.screenTitle = userHasAccount ? L10n.login : L10n.signup
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [
            AuthenticationSection(
                userHasAccount: self.userHasAccount,
                primaryButtonDelegate: self
            )
        ]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
    
    private func displayAlert(success: Bool) {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: success ? L10n.successAuthDescription : L10n.errorAuthDescription
            )
        )
    }
}

extension AuthenticationViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any CollectionFormCellViewModel)
              }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        var email: String?
        var password: String?
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? UserAccountFormType else { return }
            switch formType {
            case .email:
                email = formCellVM.value as? String
            case .password:
                password = formCellVM.value as? String
            }
        }
        
        guard let email, let password else {
            return
        }
        
        if self.userHasAccount {
            self.authenticationSerice.login(
                email: email,
                password: password
            ) { [weak self] error in
                if let error {
                    self?.displayAlert(success: false)
                } else {
                    self?.displayAlert(success: true)
                    self?.containerDelegate?.goBackToRootViewController()
                }
            }
        } else {
            self.authenticationSerice.createUser(
                email: email,
                password: password
            ) { [weak self] error in
                if let error {
                    self?.displayAlert(success: false)
                } else {
                    self?.displayAlert(success: true)
                    self?.containerDelegate?.goBackToRootViewController()
                }
            }
        }
    }
}
