//
//  ColoredCardCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

final class SmallCardCell: UICollectionViewCell, CellConfigurable {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title3bold.font
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
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? SmallCardCellViewModel else {
            return
        }
        self.contentView.backgroundColor = cellVM.cardType.backgroundColor
        self.titleLabel.text = cellVM.cardTitle
        self.titleLabel.textColor = cellVM.cardType.titleColor
        self.imageView.image = cellVM.cardType.image
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
        guard let navigationStyle = cellViewModel.navigationStyle else {
            return
        }
        _ =  Routing.shared.route(navigationStyle: navigationStyle)
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
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
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.imageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingLarge
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
            ),
            self.titleLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingRegular
            )
        ])
    }
}
