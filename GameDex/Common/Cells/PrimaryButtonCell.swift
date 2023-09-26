//
//  PrimaryButtonCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class PrimaryButtonCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var primaryButton: PrimaryButton = {
        let primaryButton = PrimaryButton(
            delegate: nil,
            shouldEnable: true
        )
        primaryButton.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.isUserInteractionEnabled = false
        return primaryButton
    }()
    
    private var buttonTitle: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.primaryButton)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? PrimaryButtonCellViewModel else {
            return
        }
        self.buttonTitle = cellVM.title
        self.primaryButton.configure(
            viewModel: ButtonViewModel(
                title: self.buttonTitle
            )
        )
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
        self.primaryButton.isEnabled = false
        self.primaryButton.updateButtonDesignForState(buttonTitle: nil)
        self.didTapPrimaryButton(cellViewModel: cellViewModel) { () -> () in
            self.primaryButton.isEnabled = true
            self.primaryButton.updateButtonDesignForState(buttonTitle: self.buttonTitle)
        }
    }

    private func didTapPrimaryButton(cellViewModel: CellViewModel, completion: () -> ()) {
        guard let cellVM = cellViewModel as? PrimaryButtonCellViewModel else {
            return
        }
        cellVM.didTapButton()
        completion()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.primaryButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.primaryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.primaryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.primaryButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
