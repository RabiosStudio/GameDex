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
    var height: CGFloat = DesignSystem.sizeBig
    
    let title: String
    var value: String?
    var formType: AddGameFormType
    var formType: FormType
    
    init(title: String,
         formType: FormType,
    ) {
        self.title = title
        self.formType = formType
    }
}
