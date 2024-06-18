//
//  AuthenticationViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

final class AuthenticationViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = false
    var isRefreshable: Bool = false
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]?
    let screenTitle: String?
    var sections: [Section] = []
    var layoutMargins: UIEdgeInsets?
    var userAccountForm: UserAccountForm
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myProfileDelegate: MyProfileViewModelDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let userHasAccount: Bool
    private let authenticationSerice: AuthenticationService
    private let alertDisplayer: AlertDisplayer
    
    init(
        userHasAccount: Bool,
        authenticationSerice: AuthenticationService,
        alertDisplayer: AlertDisplayer,
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.userHasAccount = userHasAccount
        self.authenticationSerice = authenticationSerice
        self.alertDisplayer = alertDisplayer
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
        self.screenTitle = userHasAccount ? L10n.login : L10n.signup
        self.userAccountForm = UserAccountForm()
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [
            AuthenticationSection(
                userHasAccount: self.userHasAccount,
                primaryButtonDelegate: self, 
                formDelegate: self,
                completionBlock: { [weak self] in
                    self?.didTapForgotPassword()
                }
            )
        ]
        self.configureBottomView()
        callback(nil)
    }
    
    private func configureBottomView() {
        self.containerDelegate?.configureSupplementaryView(
            contentViewFactory: PrimaryButtonContentViewFactory(
                delegate: self,
                buttonTitle: self.userHasAccount ? L10n.login : L10n.createAccount,
                shouldEnable: true,
                position: .bottom
            )
        )
    }
    
    private func didTapForgotPassword() {
        guard let email = self.userAccountForm.email else {
            self.displayAlertPasswordResetEmailSent(success: false)
            return
        }
        self.sendPasswordResetEmail(userEmail: email)
    }
    
    private func sendPasswordResetEmail(userEmail: String) {
        Task {
            guard await self.authenticationSerice.sendPasswordResetEmail(userEmail: userEmail) == nil else {
                self.displayAlertPasswordResetEmailSent(success: false)
                return
            }
            self.displayAlertPasswordResetEmailSent(success: true)
        }
    }
    
    private func displayAlertPasswordResetEmailSent(success: Bool) {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: success ? L10n.successSendingPasswordResetEmail : L10n.errorSendingPasswordResetEmail
            )
        )
    }
    
    private func displayAlertLogin(success: Bool) {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: success ? .success : .error,
                description: success ? L10n.successAuthDescription : L10n.errorAuthDescription
            )
        )
    }
}

extension AuthenticationViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let email = self.userAccountForm.email,
              let password = self.userAccountForm.password else {
            return
        }
        
        if self.userHasAccount {
            guard await self.authenticationSerice.login(
                email: email,
                password: password,
                cloudDatabase: FirestoreDatabase(),
                localDatabase: LocalDatabaseImpl()
            ) == nil else {
                self.displayAlertLogin(success: false)
                return
            }
            self.displayAlertLogin(success: true)
            self.myProfileDelegate?.reloadMyProfile()
            await self.myCollectionDelegate?.reloadCollection()
            self.containerDelegate?.goBackToRootViewController()
        } else {
            guard await self.authenticationSerice.createUser(
                email: email,
                password: password,
                cloudDatabase: FirestoreDatabase()
            ) == nil else {
                self.displayAlertLogin(success: false)
                return
            }
            self.displayAlertLogin(success: true)
            self.myProfileDelegate?.reloadMyProfile()
            await self.myCollectionDelegate?.reloadCollection()
            self.containerDelegate?.goBackToRootViewController()
        }
    }
}

extension AuthenticationViewModel: FormDelegate {
    func refreshSections() {}
    
    func didUpdate(value: Any, for type: any FormType) {
        guard let formType = type as? UserAccountFormType else {
            return
        }
        switch formType {
        case .email:
            self.userAccountForm.email = value as? String
        case .password:
            self.userAccountForm.password = value as? String
        default:
            break
        }
    }
}
