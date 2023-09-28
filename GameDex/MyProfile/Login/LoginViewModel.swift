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
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myProfileDelegate: MyProfileViewModelDelegate?
    
    init(myProfileDelegate: MyProfileViewModelDelegate?) {
        self.myProfileDelegate = myProfileDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [LoginSection(myProfileDelegate: self.myProfileDelegate)]
        callback(nil)
    }
    
}
