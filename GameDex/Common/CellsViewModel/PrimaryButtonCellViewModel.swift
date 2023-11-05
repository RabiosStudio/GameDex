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
    
    let buttonViewModel: ButtonViewModel
    let buttonType: ButtonType
    
    init(
        buttonViewModel: ButtonViewModel,
        delegate: PrimaryButtonDelegate?,
        buttonType: ButtonType = .classic,
        cellTappedCallback: (() -> Void)? = nil
    ) {
        self.buttonViewModel = buttonViewModel
        self.delegate = delegate
        self.buttonType = buttonType
        self.cellTappedCallback = cellTappedCallback
    }
    
    func didTapButton(completion: @escaping () -> ()) {
        guard let delegate = self.delegate else {
            self.cellTappedCallback?()
            completion()
            return
        }
        Task {
            await delegate.didTapPrimaryButton()
            completion()
        }
    }
}
