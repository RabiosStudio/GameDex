//
//  TextFieldCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class TextFieldCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = TextFieldCell.self
    let shouldActiveTextField: Bool
    var indexPath: IndexPath?
    var title: String
    var navigationStyle: NavigationStyle?
    var textFieldType: FormTextFieldType
    
    init(title: String, shouldActiveTextField: Bool, textFieldType: FormTextFieldType) {
        self.title = title
        self.shouldActiveTextField = shouldActiveTextField
        self.textFieldType = textFieldType
    }
    
}
