//
//  MyCollectionFiltersViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/05/2024.
//

import Foundation
import UIKit

final class MyCollectionFiltersViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = "Filters"
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    init() {}
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [MyCollectionFiltersSection(editDelegate: self)]
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        default:
            break
        }
    }
    
    private func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
}

extension MyCollectionFiltersViewModel: EditFormDelegate {
    func enableSaveButtonIfNeeded() {
    }
}
