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
    var navigationStyle: NavigationStyle?
    let height: CGFloat = DesignSystem.sizeSmall
    
    let title: String
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.editFormDelegate?.enableSaveButtonIfNeeded()
        }
    }
    
    weak var editFormDelegate: EditFormDelegate?
    
    init(title: String,
         formType: FormType,
         value: Int? = nil,
         editDelegate: EditFormDelegate? = nil
    ) {
        self.title = title
        self.formType = formType
        self.value = value
        self.editFormDelegate = editDelegate
    }
}
