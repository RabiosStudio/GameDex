//
//  LabelCollectionCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation

final class LabelCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = LabelCell.self
    var indexPath: IndexPath?
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
}
