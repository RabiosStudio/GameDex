//
//  StarRatingCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

class StarRatingCell: UICollectionViewCell, CellConfigurable {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .leading
        view.spacing = DesignSystem.paddingRegular
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.textAlignment = .left
        label.font = Typography.body.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrayImageViews: [UIImageView] = {
        let array = [UIImageView]()
        return array
    }()
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? StarRatingCellViewModel else {
            return
        }
        setupViews()
        setupConstraints()
        self.label.text = cellVM.title
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
            self.stackView.addArrangedSubview(imageView)
            self.arrayImageViews.append(imageView)
        }
    }
    
    private func handleTouchAtLocation(with touches: Set<UITouch>) {
        let touchLocation = touches.first
        let location = touchLocation?.location(in: self.stackView)
        var intRating: Int = 0
        self.arrayImageViews.forEach { (imageView) in
            if ((location?.x)! > imageView.frame.origin.x) {
                let i = self.arrayImageViews.firstIndex(of: imageView)
                intRating = i! + 1
//                let intRate = Int(intRating)
                imageView.image = UIImage(systemName: "star.fill")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
            } else {
                imageView.image = UIImage(systemName: "star")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    private func setupViews() {
        self.backgroundColor = .primaryBackgroundColor
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.label.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.label.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingLarge
            ),
            self.label.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingLarge
            ),
            
            self.stackView.topAnchor.constraint(
                equalTo: self.label.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.stackView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.5
            )
        ])
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
//        handleTouchAtLocation(with: )
    }
    
    
}
