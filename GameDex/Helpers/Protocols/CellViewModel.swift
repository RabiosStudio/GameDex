//
//  CellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

protocol CellViewModel: AnyObject {
    var cellClass: AnyClass { get set }
    var reuseIdentifier: String { get }
    var indexPath: IndexPath? { get set }
    var navigationStyle: NavigationStyle? { get set }
}

extension CellViewModel {
    var reuseIdentifier: String {
        return String(describing: self.cellClass)
    }
}
