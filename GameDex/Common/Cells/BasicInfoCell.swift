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
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3bold.font
        label.textColor = .secondaryColor
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var primarySubtitle: UILabel = {
        let label = UILabel()
        label.font = Typography.body.font
        label.textColor = .secondaryColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var secondarySubtitle: UILabel = {
        let label = UILabel()
        label.font = Typography.body.font
        label.textColor = .secondaryColor
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillProportionally
        return view
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
        self.setupViews(cellViewModel: cellViewModel)
        guard let cellVM = cellViewModel as? BasicInfoCellViewModel else {
            return
        }
        self.titleLabel.text = cellVM.title
        self.primarySubtitle.text = cellVM.subtitle1
        if let secondarySubtitle = cellVM.subtitle2 {
            self.secondarySubtitle.text = secondarySubtitle
        }
        if let imageName = cellVM.caption,
           let imageURL = URL(string: imageName),
           let placeholderImage = UIImage(named: Asset.noItems.name) {
            self.imageView.setImageWith(
                url: imageURL,
                placeholderImage: placeholderImage
            )
        }
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
        guard let navigationStyle = cellViewModel.navigationStyle else {
            return
        }
        _ =  Routing.shared.route(navigationStyle: navigationStyle)
    }
    
    private func setupViews(cellViewModel: CellViewModel) {
        self.contentView.addSubview(self.imageView)
        self.stackView.addArrangedSubview(self.titleLabel)
        guard let cellVM = cellViewModel as? BasicInfoCellViewModel else {
            return
        }
        if let shouldDisplaySubtitle = cellVM.subtitle1 {
            self.stackView.addArrangedSubview(self.primarySubtitle)
        }
        self.stackView.addArrangedSubview(self.secondarySubtitle)
        self.contentView.addSubview(self.stackView)
    }
    
    private func setupConstraints() {
        [self.imageView, self.titleLabel, self.primarySubtitle, self.secondarySubtitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
    }
}
