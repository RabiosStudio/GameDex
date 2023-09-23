//
//  TitleCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation

import UIKit

final class TitleCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.font = Typography.title3bold.font
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? TitleCellViewModel else {
            return
        }
        self.titleLabel.text = cellVM.title
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {}
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.paddingRegular),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: DesignSystem.paddingRegular),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: DesignSystem.paddingRegular),
        ])
    }
    
}
