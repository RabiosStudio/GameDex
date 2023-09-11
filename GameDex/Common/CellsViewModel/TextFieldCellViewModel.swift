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
    var size: CGFloat = DesignSystem.sizeVerySmall
    
    let placeholder: String
    var formType: FormType
    var value: ValueType?
    
    init(placeholder: String,
         formType: FormType) {
        self.placeholder = placeholder
        self.formType = formType
    }
    
}
