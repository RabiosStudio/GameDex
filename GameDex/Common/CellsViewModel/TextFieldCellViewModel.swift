//
//  TextFieldCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class TextFieldCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = FormCell.self
    let shouldActiveTextField: Bool
    var indexPath: IndexPath?
    var title: String
    var navigationStyle: NavigationStyle?
    
    init(title: String, shouldActiveTextField: Bool) {
        self.title = title
        self.shouldActiveTextField = shouldActiveTextField
    }
    
}
