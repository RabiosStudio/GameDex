//
//  CollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation
import UIKit

protocol CollectionViewModel {
    var screenTitle: String? { get }
    var buttonItems: [AnyBarButtonItem]? { get }
    var isBounceable: Bool { get }
    var isRefreshable: Bool { get }
    var searchViewModel: SearchViewModel? { get }
    var sections: [Section] { get }
    var progress: Float? { get }
    var layoutMargins: UIEdgeInsets? { get }
    var containerDelegate: ContainerViewControllerDelegate? { get set }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) async
    func didTap(buttonItem: AnyBarButtonItem) async
}

extension CollectionViewModel {
    func numberOfSections() -> Int {
        return self.sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard self.sections.count > 0 else {
            return 0
        }
        return self.sections[section].cellsVM.count
    }
    
    func item(at indexPath: IndexPath) -> CellViewModel {
        return self.sections[indexPath.section].cellsVM[indexPath.row]
    }
    
    func itemAvailable(at indexPath: IndexPath) -> Bool {
        return self.sections.count > indexPath.section && self.sections[indexPath.section].cellsVM.count > indexPath.row
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {}
}
