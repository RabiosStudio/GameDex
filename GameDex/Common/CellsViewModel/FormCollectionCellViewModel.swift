//
//  FormCollectionCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

class FormCollectionCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = FormCollectionViewCell.self
    var firstResponder: Bool
    
    var indexPath: IndexPath?
    var title: String
    
    init(title: String, firstResponder: Bool) {
        self.title = title
        self.firstResponder = firstResponder
    }
    
}
