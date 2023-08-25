//
//  PrimaryButton.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol PrimaryButtonDelegate: AnyObject {
    func didTapPrimaryButton() async
}

final class PrimaryButton: UIButton {
    weak var delegate: PrimaryButtonDelegate?
    
    init(delegate: PrimaryButtonDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.addTarget(
            self,
            action: #selector(didTapPrimaryButton(_:)),
            for: .touchUpInside
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(viewModel: ButtonViewModel) {
        self.layer.cornerRadius = DesignSystem.cornerRadiusBig
        self.backgroundColor = .secondaryColor
        self.titleLabel?.font = Typography.calloutBold.font
        self.setTitleColor(.primaryBackgroundColor, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = DesignSystem.numberOfLinesStandard
        self.setTitle(viewModel.title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupConstraints(viewModel: viewModel)
    }
    
    private func setupConstraints(viewModel: ButtonViewModel) {
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: viewModel.buttonStyle.height)
            ]
        )
    }
    
    @objc private func didTapPrimaryButton(_ sender: PrimaryButton) {
        Task {
            await self.delegate?.didTapPrimaryButton()
        }
    }
}
