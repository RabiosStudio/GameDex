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
    var navigationStyle: NavigationStyle?
    var height: CGFloat = DesignSystem.sizeVerySmall
    
    let placeholder: String
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.editFormDelegate?.enableSaveButton()
        }
    }
    let text: String?
    
    weak var editFormDelegate: EditFormDelegate?
    
    init(placeholder: String,
         formType: FormType,
         text: String?,
         editDelegate: EditFormDelegate?
    ) {
        self.placeholder = placeholder
        self.formType = formType
        self.text = text
        self.editFormDelegate = editDelegate
    }
    
}
