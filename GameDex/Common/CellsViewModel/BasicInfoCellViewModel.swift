//
//  BasicInfoCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

final class BasicInfoCellViewModel: CollectionCellViewModel {
    var cellClass: AnyClass = BasicInfoCell.self
    var indexPath: IndexPath?
    var cellTappedCallback: (() -> Void)?
    var height: CGFloat = DesignSystem.sizeRegular
    
    let title: String
    let subtitle1: String?
    let subtitle2: String?
    let caption: String?
    
    init(
        title: String,
        subtitle1: String?,
        subtitle2: String?,
        caption: String?,
        cellTappedCallback: (() -> Void)?
    ) {
        self.title = title
        self.subtitle1 = subtitle1
        self.subtitle2 = subtitle2
        self.caption = caption
        self.cellTappedCallback = cellTappedCallback
    }
}
