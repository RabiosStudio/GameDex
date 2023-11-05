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
        let primaryButton = PrimaryButton(delegate: nil)
        primaryButton.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(self.buttonCellPressed), for: .touchUpInside)
        return primaryButton
    }()
    
    private var viewModel: PrimaryButtonCellViewModel?
    
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
        self.viewModel = cellVM        
        self.primaryButton.configure(viewModel: cellVM.buttonViewModel)
        if cellVM.buttonType == .warning {
            self.primaryButton.backgroundColor = .warningColor
        }
        self.setupConstraints()
    }
    
    @objc
    private func buttonCellPressed() {
        self.primaryButton.updateButtonDesign(state: .loading)
        self.isUserInteractionEnabled = false
        
        guard let vm = self.viewModel else { return }
        vm.didTapButton { [weak self] in
            DispatchQueue.main.async {
                self?.primaryButton.updateButtonDesign(state: vm.buttonViewModel.state)
                self?.isUserInteractionEnabled = true
            }
        }
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
