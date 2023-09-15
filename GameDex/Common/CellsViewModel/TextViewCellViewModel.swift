//
//  TextViewCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class TextViewCellViewModel: CollectionFormCellViewModel {
    typealias ValueType = String
    
    var cellClass: AnyClass = TextViewCell.self
    var indexPath: IndexPath?
    var navigationStyle: NavigationStyle?
    var height: CGFloat = DesignSystem.sizeBig
    
    let title: String
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.editFormDelegate?.enableSaveButton()
        }
    }
    let text: String?
    
    weak var editFormDelegate: EditFormDelegate?
    
    init(title: String,
         formType: FormType,
         text: String?,
         editDelegate: EditFormDelegate?
    ) {
        self.title = title
        self.formType = formType
        self.text = text
        self.editFormDelegate = editDelegate
    }
}
