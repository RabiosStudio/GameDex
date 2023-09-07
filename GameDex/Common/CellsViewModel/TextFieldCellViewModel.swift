//
//  TextFieldCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class TextFieldCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = TextFieldCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var size: CGFloat = DesignSystem.sizeVerySmall
    
    let placeholder: String
    let textFieldType: TextFieldType
    
    var value: String?
    
    init(placeholder: String,
         textFieldType: TextFieldType) {
        self.placeholder = placeholder
        self.textFieldType = textFieldType
    }
    
}
