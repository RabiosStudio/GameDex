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
    
    private weak var delegate: PrimaryButtonDelegate?
    
    let buttonViewModel: ButtonViewModel
    let buttonType: ButtonType
    
    init(
        buttonViewModel: ButtonViewModel,
        delegate: PrimaryButtonDelegate?,
        buttonType: ButtonType = .classic
    ) {
        self.buttonViewModel = buttonViewModel
        self.delegate = delegate
        self.buttonType = buttonType
    }
    
    func didTap(buttonTitle: String?, completion: @escaping () -> ()) {
        Task {
            await delegate?.didTapPrimaryButton(with: buttonTitle)
            completion()
        }
    }
}
