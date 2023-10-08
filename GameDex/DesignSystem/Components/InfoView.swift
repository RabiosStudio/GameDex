//
//  InfoView.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/10/2023.
//

import Foundation
import UIKit

final class InfoView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.label)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(viewModel: InfoViewModel) {
        self.layer.cornerRadius = viewModel.cornerRadius
        self.backgroundColor = viewModel.backgroundColor
        self.alpha = viewModel.alpha
        self.label.font = viewModel.font
        self.label.text = viewModel.text
        self.label.textColor = viewModel.textColor
        self.label.textAlignment = viewModel.textAlignment
        self.label.numberOfLines = viewModel.numberOfLines
        let image = viewModel.image
        self.imageView.image = image
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: 70),
                
                self.imageView.topAnchor.constraint(
                    equalTo: self.topAnchor,
                    constant: DesignSystem.paddingRegular
                ),
                self.imageView.bottomAnchor.constraint(
                    equalTo: self.bottomAnchor,
                    constant: -DesignSystem.paddingRegular
                ),
                self.imageView.leadingAnchor.constraint(
                    equalTo: self.leadingAnchor,
                    constant: DesignSystem.paddingRegular
                ),
                self.imageView.widthAnchor.constraint(
                    equalTo: self.imageView.heightAnchor
                ),
                
                self.label.topAnchor.constraint(equalTo: self.topAnchor),
                self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.label.leadingAnchor.constraint(
                    equalTo: self.imageView.trailingAnchor,
                    constant: DesignSystem.paddingLarge
                ),
                self.label.trailingAnchor.constraint(
                    equalTo: self.trailingAnchor,
                    constant: -DesignSystem.paddingRegular
                )
            ]
        )
    }
}
