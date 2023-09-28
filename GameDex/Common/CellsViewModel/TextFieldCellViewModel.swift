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
            self.editFormDelegate?.enableSaveButtonIfNeeded()
        }
    }
    
    weak var editFormDelegate: EditFormDelegate?
    
    init(placeholder: String,
         formType: FormType,
         value: String? = nil,
         editDelegate: EditFormDelegate? = nil
    ) {
        self.placeholder = placeholder
        self.formType = formType
        self.value = value
        self.editFormDelegate = editDelegate
    }
    
}
