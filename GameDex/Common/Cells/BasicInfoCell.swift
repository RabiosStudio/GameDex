//
//  BasicInfoCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import UIKit
import SDWebImage

final class BasicInfoCell: UICollectionViewCell, CellConfigurable {
    
    private let imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3bold.font
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var primarySubtitle: UILabel = {
        let label = UILabel()
        label.font = Typography.body.font
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var secondarySubtitle: UILabel = {
        let label = UILabel()
        label.font = Typography.body.font
        label.textColor = .systemGray
        label.text = ""
        label.textAlignment = .left
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
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupViews() {
        self.backgroundColor = .primaryBackgroundColor
        self.contentView.addSubview(self.imageView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.primarySubtitle)
        self.stackView.addArrangedSubview(self.secondarySubtitle)
        self.contentView.addSubview(self.stackView)
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? BasicInfoCellViewModel else {
            return
        }
        self.titleLabel.text = cellVM.title
        self.primarySubtitle.text = cellVM.subtitle1
        if let secondarySubtitle = cellVM.subtitle2 {
            self.secondarySubtitle.text = secondarySubtitle
        }
        if let imageName = cellVM.caption,
           let imageURL = URL(string: imageName) {
            self.imageView.sd_setImage(
                with: imageURL,
                placeholderImage: UIImage(named: Asset.noItems.name)
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
