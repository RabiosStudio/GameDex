//
//  BasicInfoCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import UIKit

final class BasicInfoCell: UICollectionViewCell, CellConfigurable {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.tintColor = .primaryColor
        view.layer.cornerRadius = DesignSystem.cornerRadiusBig
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: VerticallyAlignedUILabel = {
        let label = VerticallyAlignedUILabel()
        label.font = Typography.title3bold.font
        label.textColor = .secondaryColor
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var primarySubtitle: VerticallyAlignedUILabel = {
        let label = VerticallyAlignedUILabel()
        label.font = Typography.body.font
        label.textColor = .secondaryColor
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var secondarySubtitle: VerticallyAlignedUILabel = {
        let label = VerticallyAlignedUILabel()
        label.font = Typography.body.font
        label.textColor = .secondaryColor
        label.numberOfLines = .zero
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .secondaryBackgroundColor : .clear
        }
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? BasicInfoCellViewModel else {
            return
        }
        
        if let imageName = cellVM.caption,
           let imageURL = URL(string: imageName) {
            self.imageView.setImageWith(url: imageURL)
        }
        
        if let icon = cellVM.icon {
            self.iconView.image = icon
            self.iconView.backgroundColor = .primaryBackgroundColor
        }
        
        self.titleLabel.text = cellVM.title
        
        self.setupSubviews(
            subtitle1: cellVM.subtitle1,
            subtitle2: cellVM.subtitle2
        )
        self.contentView.addSubview(self.stackView)
        
        self.setupConstraints()
    }
    
    private func setupSubviews(subtitle1: String?, subtitle2: String?) {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.iconView)
        self.stackView.addArrangedSubview(self.titleLabel)
        guard subtitle1 != nil else {
            return
        }
        self.primarySubtitle.text = subtitle1
        self.stackView.addArrangedSubview(primarySubtitle)
        guard subtitle2 != nil else {
            self.titleLabel.alignment = .bottom
            self.primarySubtitle.alignment = .top
            self.stackView.spacing = DesignSystem.paddingRegular
            return
        }
        self.secondarySubtitle.text = subtitle2
        self.stackView.addArrangedSubview(secondarySubtitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.imageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.imageView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            
            self.iconView.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            self.iconView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            self.iconView.heightAnchor.constraint(
                equalTo: self.imageView.heightAnchor,
                multiplier: DesignSystem.fractionalSizeVerySmall
            ),
            self.iconView.widthAnchor.constraint(
                equalTo: self.iconView.heightAnchor
            ),
            
            self.stackView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.imageView.trailingAnchor,
                constant: DesignSystem.paddingLarge
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -DesignSystem.paddingSmall
            ),
            self.stackView.widthAnchor.constraint(
                equalTo: self.widthAnchor, multiplier: DesignSystem.fractionalSizeBig
            )
        ])
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
}
