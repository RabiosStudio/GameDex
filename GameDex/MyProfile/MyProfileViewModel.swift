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
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
}
