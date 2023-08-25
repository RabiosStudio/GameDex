//
//  ImageAndLabelCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

final class ImageAndLabelCell: UICollectionViewCell, CellConfigurable {
    
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title2bold.font
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3.font
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupLayer()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? ImageAndLabelCellViewModel else {
            return
        }
        self.titleLabel.text = cellVM.title
        self.descriptionLabel.text = cellVM.description
        self.imageView.image = UIImage(named: cellVM.image)!
        self.setupConstraints()
    }
    
    private func setupLayer() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = DesignSystem.opacityRegular
        self.layer.shadowRadius = DesignSystem.cornerRadiusRegular
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on contentView
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = DesignSystem.cornerRadiusBig
    }
    
    private func setupConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.paddingLarge),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.paddingLarge),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.paddingLarge),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: DesignSystem.paddingLarge),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingRegular),
            self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: DesignSystem.fractionalSizeVerySmall),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: DesignSystem.paddingVerySmall),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: DesignSystem.paddingLarge),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingRegular),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.paddingLarge)
        ])
    }
}
