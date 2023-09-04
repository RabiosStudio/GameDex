//
//  TextViewCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class TextViewCellViewModel: CellViewModel {
    var cellClass: AnyClass = TextViewCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}
