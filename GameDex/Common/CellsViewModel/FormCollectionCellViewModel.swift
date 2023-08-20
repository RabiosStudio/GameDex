//
//  FormCollectionCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

class FormCollectionCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = FormCollectionViewCell.self
    
    var indexPath: IndexPath?
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
