//
//  StarRatingCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class StarRatingCellViewModel: CollectionFormCellViewModel {
    typealias ValueType = Int
    
    var cellClass: AnyClass = StarRatingCell.self
    var indexPath: IndexPath?
    var cellTappedCallback: (() -> Void)?
    let height: CGFloat = DesignSystem.sizeSmall
    
    let title: String
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.formDelegate?.didUpdate(value: self.value as Any, for: self.formType)
            self.formDelegate?.enableSaveButtonIfNeeded()
        }
    }
    
    weak var formDelegate: FormDelegate?
    
    init(title: String,
         formType: FormType,
         value: Int? = nil,
         formDelegate: FormDelegate? = nil
    ) {
        self.title = title
        self.formType = formType
        self.value = value
        self.formDelegate = formDelegate
    }
}
