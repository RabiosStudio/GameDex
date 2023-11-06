//
//  ImageDescriptionCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

class ImageDescriptionCell: UICollectionViewCell, CellConfigurable {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .secondaryColor
        label.font = Typography.title3bold.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryColor
        label.font = Typography.headline.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryColor
        label.font = Typography.headline.font
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryColor
        label.font = Typography.body.font
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? ImageDescriptionCellViewModel else {
            return
        }
        let imageURL = URL(string: cellVM.imageStringURL)!
        self.imageView.setImageWith(url: imageURL)
        
        self.title.text = cellVM.title
        self.subtitle1.text = cellVM.subtitle1
        self.subtitle2.text = cellVM.subtitle2
        self.subtitle3.text = cellVM.subtitle3
        
        self.setupConstraints()
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.stackView.addArrangedSubview(self.title)
        self.stackView.addArrangedSubview(self.subtitle1)
        self.stackView.addArrangedSubview(self.subtitle2)
        self.stackView.addArrangedSubview(self.subtitle3)
        self.contentView.addSubview(self.stackView)
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
            self.imageView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.imageView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: DesignSystem.fractionalSizeMedium
            ),
            
            self.stackView.topAnchor.constraint(
                equalTo: self.imageView.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingRegular
            )
        ])
    }
}
