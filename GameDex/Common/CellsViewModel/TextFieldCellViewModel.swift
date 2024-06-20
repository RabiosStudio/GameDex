//
//  TextFieldCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class TextFieldCellViewModel: CollectionFormCellViewModel {
    typealias ValueType = String
    
    var cellClass: AnyClass = TextFieldCell.self
    var indexPath: IndexPath?
    var cellTappedCallback: (() -> Void)?
    var height: CGFloat = DesignSystem.sizeVerySmall
    
    let placeholder: String
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.formDelegate?.didUpdate(value: self.value as Any, for: self.formType)
        }
    }
    let isEditable: Bool
    
    weak var formDelegate: FormDelegate?
    
    init(placeholder: String,
         formType: FormType,
         value: String? = nil,
         isEditable: Bool = true,
         formDelegate: FormDelegate? = nil,
         cellTappedCallback: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self.formType = formType
        self.value = value
        self.isEditable = isEditable
        self.formDelegate = formDelegate
        self.cellTappedCallback = cellTappedCallback
    }
    
}
