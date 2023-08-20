//
//  CollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

protocol CollectionViewModel {
    var screenTitle: String? { get }
    var rightButtonItem: AnyBarButtonItem? { get }
    var isScrollable: Bool { get }
    var sections: [Section] { get }
    var progress: Float? { get }
    func loadData(callback: @escaping (EmptyError?) -> ())
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
}
