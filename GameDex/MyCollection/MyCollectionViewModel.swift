//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

final class MyCollectionViewModel: CollectionViewModel {
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem?
    let screenTitle: String? = L10n.myCollection    
    var sections: [Section] = []
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let error: MyCollectionError = .noItems
        callback(error)
    }
}
