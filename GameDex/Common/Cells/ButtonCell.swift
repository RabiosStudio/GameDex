//
//  ButtonCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class ButtonCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var primaryButton: PrimaryButton = {
        let primaryButton = PrimaryButton(
            delegate: self.delegate,
            shouldEnable: true,
            displayLoaderIfNeeded: false
        )
        primaryButton.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        return primaryButton
    }()
    
    weak var delegate: PrimaryButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.primaryButton)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? ButtonCellViewModel else {
            return
        }
        self.primaryButton.configure(
            viewModel: ButtonViewModel(
                title: cellVM.title
            )
        )
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
        guard let navigationStyle = cellViewModel.navigationStyle else {
            return
        }
        _ =  Routing.shared.route(navigationStyle: navigationStyle)
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
