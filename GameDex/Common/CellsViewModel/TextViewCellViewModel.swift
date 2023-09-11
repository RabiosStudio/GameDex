//
//  TextViewCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class TextViewCellViewModel: CollectionFormCellViewModel {
    var cellClass: AnyClass = TextViewCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var size: CGFloat = DesignSystem.sizeBig
    
    let title: String
    var value: String?
    var formType: FormType = .notes
    
    init(title: String) {
        self.title = title
    }
}
