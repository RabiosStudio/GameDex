//
//  BasicCardCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class BasicCardCell: UICollectionViewCell, CellConfigurable {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title2bold.font
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3.font
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? CardCellViewModel else {
            return
        }
        self.contentView.backgroundColor = cellVM.cardType.backgroundColor
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        if cellVM.cardDescription != nil {
            self.descriptionLabel.text = cellVM.cardDescription
            self.contentView.addSubview(self.descriptionLabel)
        }
        self.titleLabel.text = cellVM.cardTitle
        self.titleLabel.textColor = cellVM.cardType.textColor
        self.imageView.image = cellVM.cardType.image
        
        self.setupLayer()
        self.setupConstraints(cellViewModel: cellViewModel)
    }
    
    private func setupLayer() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = DesignSystem.shadowOpacityRegular
        self.layer.shadowRadius = DesignSystem.cornerRadiusRegular
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on contentView
        self.contentView.layer.cornerRadius = DesignSystem.cornerRadiusBig
    }
    
    private func setupConstraints(cellViewModel: CellViewModel) {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.imageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.imageView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingRegular
            ),
            self.imageView.widthAnchor.constraint(
                equalTo: self.imageView.heightAnchor
            ),
            
            self.titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.imageView.trailingAnchor,
                constant: DesignSystem.paddingLarge
            ),
            self.titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingRegular
            )
        ])
        
        guard let cellVM = cellViewModel as? CardCellViewModel else {
            return
        }
        guard cellVM.cardDescription != nil else {
            NSLayoutConstraint.activate([
                self.titleLabel.bottomAnchor.constraint(
                    equalTo: self.bottomAnchor,
                    constant: -DesignSystem.paddingRegular
                )
            ])
            return
        }
        NSLayoutConstraint.activate([
            self.titleLabel.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: DesignSystem.fractionalSizeVerySmall
            ),
            self.descriptionLabel.topAnchor.constraint(
                equalTo: self.titleLabel.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.descriptionLabel.leadingAnchor.constraint(
                equalTo: self.imageView.trailingAnchor,
                constant: DesignSystem.paddingLarge
            ),
            self.descriptionLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingRegular
            ),
            self.descriptionLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingLarge
            )
        ])
    }
}
