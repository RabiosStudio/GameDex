//
//  SelectAddGameTypeViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectAddGameMethodViewModel: CollectionViewModel {
    var searchViewModel = SearchViewModel(
        isSearchable: false,
        isActivated: false
    )
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.addGame
    var sections: [Section]
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    init() {
        self.sections = [SelectAddGameMethodSection()]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
}
