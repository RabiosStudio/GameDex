//
//  TitleCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class TitleCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = TitleCell.self
    var indexPath: IndexPath?
    var height: CGFloat
    var cellTappedCallback: (() -> Void)?
    
    let title: String
    
    init(title: String, size: CellSize) {
        self.title = title
        self.height = size.height
    }
    
}
