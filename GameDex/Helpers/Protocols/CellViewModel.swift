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
    var cellTappedCallback: (() -> Void)? { get set }
}

extension CellViewModel {
    var reuseIdentifier: String {
        return String(describing: self.cellClass)
    }
}

protocol CollectionCellViewModel: CellViewModel {
    var height: CGFloat { get }
}

// MARK: - Button
protocol ButtonCollectionCellViewModel: CollectionCellViewModel {
    func didTapButton()
}

// MARK: - Cards

protocol CollectionCardCellViewModel: CollectionCellViewModel, CardCellViewModel {}

protocol CardCellViewModel {
    var cardType: CardType { get set }
    var cardTitle: String { get }
    var cardDescription: String? { get }
}

// MARK: - Forms

protocol CollectionFormCellViewModel: CollectionCellViewModel, FormCellViewModel {}

protocol FormCellViewModel {
    associatedtype ValueType
    
    var formType: FormType { get set }
    var value: ValueType? { get set }
    var editFormDelegate: EditFormDelegate? { get }
}

// sourcery: AutoMockable
protocol EditFormDelegate: AnyObject {
    func enableSaveButtonIfNeeded()
}
