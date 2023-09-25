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
    var containerDelegate: ContainerViewControllerDelegate?
    
    private let userHasAccount: Bool
    
    init(userHasAccount: Bool) {
        self.userHasAccount = userHasAccount
        self.screenTitle = userHasAccount ? L10n.login : L10n.signup
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [AuthenticationSection(userHasAccount: self.userHasAccount)]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
}
