//
//  PrimaryButtonCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

final class PrimaryButtonCellViewModel: ButtonCollectionCellViewModel {
    var cellClass: AnyClass = PrimaryButtonCell.self
    var indexPath: IndexPath?
    var height: CGFloat = DesignSystem.buttonHeightRegular
    var cellTappedCallback: (() -> Void)?
    
    private let delegate: PrimaryButtonDelegate?
    
    let title: String
    
    init(
        title: String,
        delegate: PrimaryButtonDelegate?,
        cellTappedCallback: (() -> Void)? = nil
    ) {
        self.title = title
        self.delegate = delegate
        self.cellTappedCallback = cellTappedCallback
    }
    
    func didTapButton() {
        Task {
            await self.delegate?.didTapPrimaryButton()
        }
    }
}
