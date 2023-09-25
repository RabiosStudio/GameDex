//
//  LoginViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class LoginViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.login
    var sections: [Section] = []
    var containerDelegate: ContainerViewControllerDelegate?
    
    init() {}
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [LoginSection()]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
}
