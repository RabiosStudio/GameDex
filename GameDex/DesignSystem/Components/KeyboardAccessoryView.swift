//
//  KeyboardAccessoryView.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/06/2024.
//

import Foundation
import UIKit

class KeyboardAccessoryView: UIView {
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.done, for: .normal)
        button.setTitleColor(.primaryColor, for: .normal)
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.cancel, for: .normal)
        button.setTitleColor(.primaryColor, for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: KeyboardDelegate?
    private let showCancelButton: Bool
    
    init(
        delegate: KeyboardDelegate?,
        showCancelButton: Bool
    ) {
        self.showCancelButton = showCancelButton
        super.init(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: .zero,
                height: DesignSystem.buttonSizeRegular
            )
        )
        self.delegate = delegate
        self.addSubview(self.doneButton)
        if showCancelButton {
            self.addSubview(self.cancelButton)
        }
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    @objc private func didTapDoneButton() {
        self.delegate?.didTapDoneButton()
    }
    
    @objc private func didTapCancelButton() {
        self.delegate?.didTapCancelButton()
    }
    
    private func setupConstraints() {
        if self.showCancelButton {
            NSLayoutConstraint.activate([
                self.cancelButton.topAnchor.constraint(equalTo: self.topAnchor),
                self.cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular)
            ])
        }
        NSLayoutConstraint.activate([
            self.doneButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingRegular)
        ])
    }
}
