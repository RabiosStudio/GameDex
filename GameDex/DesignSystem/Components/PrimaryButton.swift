//
//  PrimaryButton.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit

final class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(viewModel: ButtonViewModel) {
        self.layer.cornerRadius = DesignSystem.cornerRadiusBig
        self.backgroundColor = UIColor.primaryColor
        self.titleLabel?.font = Typography.calloutBold.font
        self.titleLabel?.tintColor = .white
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
}
