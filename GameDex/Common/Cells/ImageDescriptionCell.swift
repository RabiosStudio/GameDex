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
        label.font = Typography.title2bold.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitle1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryColor
        label.font = Typography.title3.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitle2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryColor
        label.font = Typography.body.font
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        let placeholderImage = UIImage(systemName: "eraser")!
        self.imageView.setImageWith(url: imageURL, placeholderImage: placeholderImage)
        
        self.title.text = cellVM.title
        self.subTitle1.text = cellVM.subtitle1
        self.subTitle2.text = cellVM.subtitle2
        
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {}
    
    private func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.subTitle1)
        self.contentView.addSubview(self.subTitle2)
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
            
            self.title.topAnchor.constraint(
                equalTo: self.imageView.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.title.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.title.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            
            self.subTitle1.topAnchor.constraint(
                equalTo: self.title.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.subTitle1.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.subTitle1.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            
            self.subTitle2.topAnchor.constraint(
                equalTo: self.subTitle1.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.subTitle2.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.subTitle2.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.subTitle2.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingRegular
            )
        ])
    }
}
