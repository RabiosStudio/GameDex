//
//  TextFieldCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class TextFieldCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = TextFieldCell.self
    let shouldActiveTextField: Bool
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var size: CGFloat = DesignSystem.sizeVerySmall
    
    var textFieldType: FormTextFieldType
    var title: String
    
    init(title: String, shouldActiveTextField: Bool, textFieldType: FormTextFieldType) {
        self.title = title
        self.shouldActiveTextField = shouldActiveTextField
        self.textFieldType = textFieldType
    }
    
}
