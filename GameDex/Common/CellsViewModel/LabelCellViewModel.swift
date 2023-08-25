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
    var alignement: TextAlignment
    
    init(text: String, alignment: TextAlignment) {
        self.text = text
        self.alignement = alignment
    }
    
}
