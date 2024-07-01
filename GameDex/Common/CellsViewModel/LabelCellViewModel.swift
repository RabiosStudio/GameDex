//
//  LabelCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation

final class LabelCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = LabelCell.self
    var indexPath: IndexPath?
    var cellTappedCallback: (() -> Void)?
    var height: CGFloat = DesignSystem.sizeTiny
    
    var text: String
    var isEditable: Bool
    var isDeletable: Bool
    
    weak var objectManagementDelegate: ObjectManagementDelegate?
    
    init(
        text: String,
        isEditable: Bool = false,
        isDeletable: Bool = false,
        objectManagementDelegate: ObjectManagementDelegate? = nil,
        cellTappedCallback: (() -> Void)? = nil
    ) {
        self.text = text
        self.isEditable = isEditable
        self.isDeletable = isDeletable
        self.objectManagementDelegate = objectManagementDelegate
        self.cellTappedCallback = cellTappedCallback
    }
    
}
