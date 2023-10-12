//
//  LoginViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class LoginViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]?
    let screenTitle: String? = L10n.login
    var sections: [Section] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myProfileDelegate: MyProfileViewModelDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(
        myProfileDelegate: MyProfileViewModelDelegate?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.myProfileDelegate = myProfileDelegate
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [
            LoginSection(
                myProfileDelegate: self.myProfileDelegate,
                myCollectionDelegate: self.myCollectionDelegate
            )
        ]
        callback(nil)
    }
    
}
