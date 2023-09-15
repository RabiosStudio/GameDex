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
    var navigationStyle: NavigationStyle? { get }
}

extension CellViewModel {
    var reuseIdentifier: String {
        return String(describing: self.cellClass)
    }
}

protocol CollectionCellViewModel: CellViewModel {
    var height: CGFloat { get }
}

protocol CollectionFormCellViewModel: CollectionCellViewModel, FormCellViewModel {}

protocol FormCellViewModel {
    associatedtype ValueType
    
    var formType: FormType { get set }
    var value: ValueType? { get set }
    var editFormDelegate: EditFormDelegate? { get }
}
protocol EditFormDelegate: AnyObject {
    func enableSaveButton()
}

